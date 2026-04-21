using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Filters;
using PA_PROYECTO_ESPIGADORADA.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    public class AccountController : BaseController
    {
        [HttpGet]
        [ActionName("Profile")]
        public ActionResult UserProfile()
        {
            if (Session["User_ID"] == null)
            {
                return RedirectToAction("Login", "Security");
            }

            int userId = int.Parse(Session["User_ID"].ToString());

            using (var context = new Espiga_DBEntities())
            {
                var user = context.users
                    .Include(u => u.roles)
                    .FirstOrDefault(u => u.user_id == userId);

                if (user == null)
                {
                    return RedirectToAction("Logout", "Home");
                }

                var userOrders = context.sales_invoices
                    .Where(o => o.user_id == userId)
                    .ToList();

                var model = new UserProfileViewModel
                {
                    UserId = user.user_id,
                    Identification = user.identification,
                    Name = user.name,
                    Email = user.email,
                    RoleName = user.roles != null ? user.roles.role_name : "Usuario",
                    IsActive = user.is_active == 1,
                    TotalOrders = userOrders.Count,
                    TotalSpent = userOrders.Any() ? userOrders.Sum(o => o.total) : 0,
                    LastOrderDate = userOrders.Any() ? userOrders.Max(o => (DateTime?)o.sales_datetime) : null
                };

                return View("Profile", model);
            }
        }

        [HttpGet]
        public ActionResult MyOrders()
        {
            if (Session["User_ID"] == null)
            {
                return RedirectToAction("Login", "Security");
            }

            int userId = int.Parse(Session["User_ID"].ToString());

            using (var context = new Espiga_DBEntities())
            {
                var orders = context.sales_invoices
                    .Include(o => o.sales_invoice_lines.Select(l => l.products))
                    .Where(o => o.user_id == userId)
                    .OrderByDescending(o => o.sales_datetime)
                    .ToList();

                var model = orders.Select(order => new MyOrderViewModel
                {
                    SalesInvoiceId = order.sales_invoice_id,
                    SalesNumber = string.IsNullOrWhiteSpace(order.sales_number)
                        ? "PED-" + order.sales_invoice_id
                        : order.sales_number,
                    SalesDate = order.sales_datetime,
                    Status = order.status,
                    PaymentMethod = order.payment_method,
                    PaymentReference = order.payment_reference,
                    Subtotal = order.subtotal,
                    DiscountTotal = order.discount_total,
                    TaxTotal = order.tax_total,
                    Total = order.total,
                    Notes = order.notes,
                    Lines = order.sales_invoice_lines
                        .OrderBy(l => l.sales_invoice_line_id)
                        .Select(line => new MyOrderLineViewModel
                        {
                            ProductName = line.products != null ? line.products.product_name : "Producto",
                            Quantity = line.qty_sold,
                            UnitPrice = line.unit_price_final,
                            TaxAmount = line.tax_amount,
                            LineTotal = line.line_total
                        })
                        .ToList()
                }).ToList();

                return View(model);
            }
        }

        [HttpGet]
        public ActionResult EditProfile()
        {
            if (Session["User_ID"] == null)
            {
                return RedirectToAction("Login", "Security");
            }

            int userId = int.Parse(Session["User_ID"].ToString());
            return RedirectToAction("Edit", "Users", new { id = userId, fromProfile = true });
        }
    }
}
