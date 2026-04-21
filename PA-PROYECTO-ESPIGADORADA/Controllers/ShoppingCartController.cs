using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Filters;
using PA_PROYECTO_ESPIGADORADA.Models;
using PA_PROYECTO_ESPIGADORADA.Services;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class ShoppingCartController : BaseController
    {
        private readonly Generals generals = new Generals();

        private List<ShoppingCartItem> GetCart()
        {
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new List<ShoppingCartItem>();
            }
            return (List<ShoppingCartItem>)Session["Cart"];
        }

        private List<SelectListItem> GetPaymentMethods()
        {
            using (var db = new Espiga_DBEntities())
            {
                var methods = db.sales_invoices
                    .Select(x => x.payment_method)
                    .Concat(db.supplier_payments.Select(x => x.payment_method))
                    .Where(x => x != null && x != "")
                    .Distinct()
                    .OrderBy(x => x)
                    .ToList();

                if (!methods.Any())
                {
                    methods = new List<string>
                    {
                        "Efectivo",
                        "Tarjeta",
                        "Transferencia",
                        "SINPE Móvil"
                    };
                }

                return methods
                    .Select(x => new SelectListItem
                    {
                        Text = x,
                        Value = x
                    })
                    .ToList();
            }
        }

        private string BuildOrderItemsXml(List<ShoppingCartItem> cart)
        {
            var xml = new StringBuilder();
            xml.Append("<items>");

            foreach (var item in cart)
            {
                xml.AppendFormat(
                    CultureInfo.InvariantCulture,
                    "<item product_id=\"{0}\" qty=\"{1}\" unit_price=\"{2}\" />",
                    item.ProductId,
                    item.Quantity,
                    item.UnitPrice
                );
            }

            xml.Append("</items>");
            return xml.ToString();
        }

        private void SendOrderConfirmationEmail(sales_invoices invoice)
        {
            if (invoice == null || invoice.users == null || string.IsNullOrWhiteSpace(invoice.users.email))
            {
                return;
            }

            string htmlRoute = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Template", "OrderConfirmation.html");
            if (!System.IO.File.Exists(htmlRoute))
            {
                return;
            }

            string htmlContent = System.IO.File.ReadAllText(htmlRoute);
            var rows = new StringBuilder();

            foreach (var line in invoice.sales_invoice_lines)
            {
                rows.Append("<tr>");
                rows.AppendFormat("<td style='padding: 10px; border: 1px solid #EEEEEE;'>{0}</td>", HttpUtility.HtmlEncode(line.products != null ? line.products.product_name : "Producto"));
                rows.AppendFormat("<td style='padding: 10px; border: 1px solid #EEEEEE; text-align: center;'>{0:N0}</td>", line.qty_sold);
                rows.AppendFormat("<td style='padding: 10px; border: 1px solid #EEEEEE; text-align: right;'>₡{0:N2}</td>", line.unit_price_final);
                rows.AppendFormat("<td style='padding: 10px; border: 1px solid #EEEEEE; text-align: right;'>₡{0:N2}</td>", line.tax_amount);
                rows.AppendFormat("<td style='padding: 10px; border: 1px solid #EEEEEE; text-align: right;'>₡{0:N2}</td>", line.line_total);
                rows.Append("</tr>");
            }

            string finalHtml = htmlContent
                .Replace("{{USER_NAME}}", HttpUtility.HtmlEncode(invoice.users.name))
                .Replace("{{ORDER_NUMBER}}", HttpUtility.HtmlEncode(invoice.sales_number))
                .Replace("{{ORDER_DATE}}", invoice.sales_datetime.ToString("dd/MM/yyyy HH:mm"))
                .Replace("{{ORDER_STATUS}}", HttpUtility.HtmlEncode(invoice.status))
                .Replace("{{PAYMENT_METHOD}}", HttpUtility.HtmlEncode(invoice.payment_method))
                .Replace("{{PAYMENT_REFERENCE}}", HttpUtility.HtmlEncode(string.IsNullOrWhiteSpace(invoice.payment_reference) ? "No aplica" : invoice.payment_reference))
                .Replace("{{NOTES}}", HttpUtility.HtmlEncode(string.IsNullOrWhiteSpace(invoice.notes) ? "Sin notas" : invoice.notes))
                .Replace("{{ORDER_ITEMS}}", rows.ToString())
                .Replace("{{SUBTOTAL}}", "₡" + invoice.subtotal.ToString("N2"))
                .Replace("{{DISCOUNT_TOTAL}}", "₡" + invoice.discount_total.ToString("N2"))
                .Replace("{{TAX_TOTAL}}", "₡" + invoice.tax_total.ToString("N2"))
                .Replace("{{TOTAL}}", "₡" + invoice.total.ToString("N2"));

            generals.SendEmail(invoice.users.email, "Confirmación de pedido " + invoice.sales_number, finalHtml);
        }

        public ActionResult Index()
        {
            var cart = GetCart();
            return View(cart);
        }

        [ActiveSession]
        [HttpGet]
        public ActionResult ConfirmOrder()
        {
            var cart = GetCart();

            if (cart == null || !cart.Any())
            {
                TempData["Success"] = "No hay productos en el carrito para confirmar.";
                return RedirectToAction("Index");
            }

            var model = new CheckoutViewModel
            {
                Items = cart,
                PaymentMethods = GetPaymentMethods()
            };

            return View(model);
        }

        [ActiveSession]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PlaceOrder(CheckoutViewModel model)
        {
            var cart = GetCart();
            model.Items = cart;
            model.PaymentMethods = GetPaymentMethods();

            if (cart == null || !cart.Any())
            {
                ViewBag.Mensaje = "El carrito está vacío.";
                return View("ConfirmOrder", model);
            }

            if (!model.ConfirmPurchase)
            {
                ViewBag.Mensaje = "Debe confirmar que desea realizar la compra.";
                return View("ConfirmOrder", model);
            }

            if (!ModelState.IsValid)
            {
                return View("ConfirmOrder", model);
            }

            int userId = int.Parse(Session["User_ID"].ToString());
            string auditUser = GetAuditUser();
            OrderProcessResult result;

            using (var db = new Espiga_DBEntities())
            {
                result = db.Database.SqlQuery<OrderProcessResult>(
                    @"EXEC sales.ProcessOrder
                        @UserId,
                        @PaymentMethod,
                        @PaymentReference,
                        @Notes,
                        @CreatedBy,
                        @ItemsXml",
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@PaymentMethod", model.PaymentMethod),
                    new SqlParameter("@PaymentReference", (object)model.PaymentReference ?? DBNull.Value),
                    new SqlParameter("@Notes", (object)model.Notes ?? DBNull.Value),
                    new SqlParameter("@CreatedBy", auditUser),
                    new SqlParameter("@ItemsXml", BuildOrderItemsXml(cart))
                ).FirstOrDefault();

                if (result == null || result.SalesInvoiceId <= 0 || result.Status == "ERROR")
                {
                    ViewBag.Mensaje = result != null ? result.Message : "No fue posible procesar el pedido.";
                    return View("ConfirmOrder", model);
                }

                var invoice = db.sales_invoices
                    .Include("users")
                    .Include("sales_invoice_lines.products")
                    .FirstOrDefault(x => x.sales_invoice_id == result.SalesInvoiceId);

                try
                {
                    SendOrderConfirmationEmail(invoice);
                }
                catch
                {
                    TempData["Success"] = "Pedido " + result.SalesNumber + " generado correctamente, pero no se pudo enviar el correo.";
                }
            }

            Session["Cart"] = new List<ShoppingCartItem>();

            if (TempData["Success"] == null)
            {
                TempData["Success"] = "Pedido generado correctamente.";
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        public JsonResult AddToCart(int productId, int quantity)
        {
            var cart = GetCart();
            var item = cart.FirstOrDefault(i => i.ProductId == productId);

            using (var db = new Espiga_DBEntities())
            {
                var product = db.products.FirstOrDefault(p => p.product_id == productId);
                if (product == null)
                    return Json(new { success = false, message = "Producto no encontrado." });

                var stock = product.inventory_stock.FirstOrDefault() != null ? product.inventory_stock.FirstOrDefault().qty_available : 0;

                if (item == null)
                {
                    if (quantity > stock) return Json(new { success = false, message = "Stock insuficiente." });
                    cart.Add(new ShoppingCartItem
                    {
                        ProductId = product.product_id,
                        ProductName = product.product_name,
                        ImageUrl = string.IsNullOrEmpty(product.image_url) ? null : product.image_url,
                        UnitPrice = product.unit_price,
                        Quantity = quantity,
                        AvailableStock = stock
                    });
                }
                else
                {
                    if (item.Quantity + quantity > stock) return Json(new { success = false, message = "Límite de stock excedido." });
                    item.Quantity += quantity;
                }
            }

            return Json(new { success = true, totalItems = cart.Sum(i => i.Quantity) });
        }

        [HttpPost]
        public ActionResult UpdateQuantity(int productId, int quantity)
        {
            var cart = GetCart();
            var item = cart.FirstOrDefault(i => i.ProductId == productId);
            if (item != null)
            {
                if (quantity > item.AvailableStock) quantity = (int)item.AvailableStock;
                if (quantity <= 0) cart.Remove(item);
                else item.Quantity = quantity;
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult Remove(int productId)
        {
            var cart = GetCart();
            var item = cart.FirstOrDefault(i => i.ProductId == productId);
            if (item != null) cart.Remove(item);
            return RedirectToAction("Index");
        }
    }
}
