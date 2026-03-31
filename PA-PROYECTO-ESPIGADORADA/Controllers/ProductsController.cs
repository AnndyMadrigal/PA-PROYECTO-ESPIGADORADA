using System.Linq;
using System.Web.Mvc;
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class ProductsController : Controller
    {
        private string GetAuditUser()
        {
            return Session["Name"] != null ? Session["Name"].ToString() : "Sistema";
        }

        // DROPDOWNS
        private void LoadDropdowns()
        {
            using (var db = new Espiga_DBEntities())
            {
                ViewBag.Categories = new SelectList(
                    db.product_categories.Where(c => c.is_active == 1).ToList(),
                    "category_id",
                    "category_name"
                );

                ViewBag.Taxes = new SelectList(
                    db.taxes.Where(t => t.is_active == 1).ToList(),
                    "tax_id",
                    "tax_name"
                );
            }
        }

        // LISTA
        public ActionResult Index()
        {
            using (var db = new Espiga_DBEntities())
            {
                var lista = db.products.Select(p => new ProductViewModel
                {
                    product_id = p.product_id,
                    product_name = p.product_name,
                    sku = p.sku,
                    description = p.description,
                    image_url = p.image_url,
                    category_id = p.category_id,
                    unit_of_measure = p.unit_of_measure,
                    min_stock = p.min_stock,
                    tax_id = p.tax_id,
                    is_active = p.is_active
                }).ToList();

                return View(lista);
            }
        }

        // CREATE (GET)
        public ActionResult Create()
        {
            LoadDropdowns();
            return View();
        }

        // CREATE (POST)
        [HttpPost]
        public ActionResult Create(ProductViewModel model)
        {
            if (ModelState.IsValid)
            {
                string user = GetAuditUser();

                using (var db = new Espiga_DBEntities())
                {
                    db.Database.ExecuteSqlCommand(
                        @"EXEC core.InsertProduct 
                          @p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9",

                        model.product_name,
                        model.sku,
                        model.description ?? "",
                        model.image_url ?? "",
                        model.category_id,
                        model.unit_of_measure ?? "Unidad",
                        model.min_stock,
                        model.tax_id,
                        model.is_active,
                        user
                    );
                }

                TempData["Success"] = "Producto ingresado correctamente";
                return RedirectToAction("Index");
            }

            LoadDropdowns();
            return View(model);
        }

        // EDIT (GET)
        public ActionResult Edit(int id)
        {
            using (var db = new Espiga_DBEntities())
            {
                var p = db.products.Find(id);

                if (p == null)
                    return RedirectToAction("Index");

                var model = new ProductViewModel
                {
                    product_id = p.product_id,
                    product_name = p.product_name,
                    sku = p.sku,
                    description = p.description,
                    image_url = p.image_url,
                    category_id = p.category_id,
                    unit_of_measure = p.unit_of_measure,
                    min_stock = p.min_stock,
                    tax_id = p.tax_id,
                    is_active = p.is_active
                };

                LoadDropdowns();
                return View(model);
            }
        }

        // EDIT (POST)
        [HttpPost]
        public ActionResult Edit(ProductViewModel model)
        {
            if (ModelState.IsValid)
            {
                string user = GetAuditUser();

                using (var db = new Espiga_DBEntities())
                {
                    db.Database.ExecuteSqlCommand(
                        @"EXEC core.UpdateProduct 
                          @p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10",

                        model.product_id,
                        model.product_name,
                        model.sku,
                        model.description ?? "",
                        model.image_url ?? "",
                        model.category_id,
                        model.unit_of_measure ?? "Unidad",
                        model.min_stock,
                        model.tax_id,
                        model.is_active,
                        user
                    );
                }

                TempData["Success"] = "Producto actualizado correctamente ✏️";
                return RedirectToAction("Index");
            }

            LoadDropdowns();
            return View(model);
        }

        // DELETE LÓGIC0
        [HttpPost]
        public ActionResult ToggleStatus(int id)
        {
            string user = GetAuditUser();

            using (var db = new Espiga_DBEntities())
            {
                var exists = db.Database.SqlQuery<int>(
                    "SELECT CASE WHEN OBJECT_ID('core.ToggleProductStatus','P') IS NULL THEN 0 ELSE 1 END"
                ).FirstOrDefault() == 1;

                if (!exists)
                {
                    db.Database.ExecuteSqlCommand(
                        @"UPDATE core.products 
                          SET is_active = CASE WHEN is_active = 1 THEN 0 ELSE 1 END,
                              modified_by = @p1,
                              modified_at = GETDATE()
                          WHERE product_id = @p0",
                        id,
                        user
                    );
                }
                else
                {
                    db.Database.ExecuteSqlCommand(
                        "EXEC core.ToggleProductStatus @p0, @p1",
                        id,
                        user
                    );
                }
            }

            TempData["Success"] = "Estado del producto actualizado 🔄";
            return RedirectToAction("Index");
        }
    }
}






