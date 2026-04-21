using System.Linq;
using System.Web.Mvc;
using Newtonsoft.Json;
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class PurchaseOrdersController : Controller
    {
        private string GetUser()
        {
            return Session["Name"] != null ? Session["Name"].ToString() : "Sistema";
        }

        private void LoadDropdowns()
        {
            using (var db = new Espiga_DBEntities())
            {
                ViewBag.Suppliers = new SelectList(
                    db.suppliers.Where(s => s.is_active == 1).ToList(),
                    "supplier_id",
                    "name"
                );

                ViewBag.Products = new SelectList(
                    db.products.Where(p => p.is_active == 1).ToList(),
                    "product_id",
                    "product_name"
                );
            }
        }

        // =========================
        // LISTAR ÓRDENES 
        // =========================
        public ActionResult Index()
        {
            using (var db = new Espiga_DBEntities())
            {
                var lista = db.purchase_orders
                    .Join(db.suppliers,
                        o => o.supplier_id,
                        s => s.supplier_id,
                        (o, s) => new
                        {
                            o.order_id,
                            supplier_name = s.name,
                            o.created_at,
                            o.created_by
                        })
                    .ToList();

                return View(lista);
            }
        }

        // =========================
        // CREATE GET
        // =========================
        public ActionResult Create()
        {
            LoadDropdowns();
            return View();
        }

        // =========================
        // CREATE POST
        // =========================
        [HttpPost]
        public ActionResult Create(OrderViewModel model)
        {
            if (model.details == null || model.details.Count == 0)
            {
                ModelState.AddModelError("", "Debe agregar al menos un producto");
            }

            if (ModelState.IsValid)
            {
                string json = JsonConvert.SerializeObject(model.details);
                string user = GetUser();

                using (var db = new Espiga_DBEntities())
                {
                    db.Database.ExecuteSqlCommand(
                        "EXEC purchasing.InsertPurchaseOrder @p0, @p1, @p2",
                        model.supplier_id,
                        user,
                        json
                    );
                }

                TempData["Success"] = "Orden creada correctamente 🧾";
                return RedirectToAction("Index"); 
            }

            LoadDropdowns();
            return View(model);
        }
    }
}


