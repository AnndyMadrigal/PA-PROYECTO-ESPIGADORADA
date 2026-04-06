using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class ShoppingCartController : Controller
    {
        private List<ShoppingCartItem> GetCart()
        {
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new List<ShoppingCartItem>();
            }
            return (List<ShoppingCartItem>)Session["Cart"];
        }

        public ActionResult Index()
        {
            var cart = GetCart();
            return View(cart);
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

                var stock = product.inventory_stock.FirstOrDefault()?.qty_available ?? 0;

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