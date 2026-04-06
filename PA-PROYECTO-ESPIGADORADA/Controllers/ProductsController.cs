using System.IO;
using System.Linq;
using System.Web;
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

        // CATÁLOGO DE PRODUCTOS (VISTA DE CARTAS)
        public ActionResult Catalog()
        {
            using (var db = new Espiga_DBEntities())
            {
                var lista = db.products
                    .Where(p => p.is_active == 1 && p.inventory_stock.Any(inv => inv.qty_available > 0))
                    .Select(p => new ProductViewModel
                    {
                        product_id = p.product_id,
                        product_name = p.product_name,
                        sku = p.sku,
                        description = p.description,
                        image_url = p.image_url,
                        category_id = p.category_id,
                        unit_of_measure = p.unit_of_measure,
                        min_stock = p.min_stock,
                        unit_price = p.unit_price,
                        qty_available = p.inventory_stock.Select(inv => inv.qty_available).FirstOrDefault(),
                        tax_id = p.tax_id,
                        is_active = p.is_active
                    }).ToList();

                return View(lista);
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
                    unit_price = p.unit_price,
                    qty_available = p.inventory_stock.Select(inv => inv.qty_available).FirstOrDefault(),
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
        public ActionResult Create(ProductViewModel model, HttpPostedFileBase imageFile)
        {
            string user = GetAuditUser();

            // Manejo de la imagen: guardarla en una carpeta del proyecto
            if (imageFile != null && imageFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(imageFile.FileName);
                string uploadsFolder = Server.MapPath("~/Template/img/products/");

                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                // Usar un nombre único para evitar sobreescribir imágenes
                string uniqueFileName = System.Guid.NewGuid().ToString() + "_" + fileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);

                imageFile.SaveAs(filePath);
                model.image_url = "/Template/img/products/" + uniqueFileName;
            }

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

                // Actualizar el precio de unidad recien insertado mediante el SKU (asumiendo que SKU es unico)
                db.Database.ExecuteSqlCommand(
                    @"UPDATE core.products SET unit_price = @p0 WHERE sku = @p1", 
                    model.unit_price, 
                    model.sku
                );

                // Insertar el stock inicial
                var newProduct = db.products.FirstOrDefault(p => p.sku == model.sku);
                if (newProduct != null)
                {
                    db.inventory_stock.Add(new inventory_stock
                    {
                        product_id = newProduct.product_id,
                        qty_available = model.qty_available,
                        created_by = user,
                        created_at = System.DateTime.Now,
                        action = "Initial Stock"
                    });
                    db.SaveChanges();
                }
            }

            TempData["Success"] = "Producto ingresado correctamente";
            return RedirectToAction("Index");
        }

        // EDIT (GET)
        public ActionResult Edit(int id)
        {
            using (var db = new Espiga_DBEntities())
            {
                var p = db.products.Find(id);

                if (p == null)
                    return RedirectToAction("Index");

                // Buscar el stock explícitamente para evitar problemas si lazy loading está apagado
                var stock = db.inventory_stock.FirstOrDefault(i => i.product_id == p.product_id);

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
                    unit_price = p.unit_price,
                    qty_available = stock != null ? stock.qty_available : 0,
                    tax_id = p.tax_id,
                    is_active = p.is_active
                };

                LoadDropdowns();
                return View(model);
            }
        }

        // EDIT (POST)
        [HttpPost]
        public ActionResult Edit(ProductViewModel model, HttpPostedFileBase imageFile)
        {
            string user = GetAuditUser();

            // Manejo de la imagen: guardarla en una carpeta del proyecto
            if (imageFile != null && imageFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(imageFile.FileName);
                string uploadsFolder = Server.MapPath("~/Template/img/products/");

                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                // Usar un nombre único para evitar sobreescribir imágenes
                string uniqueFileName = System.Guid.NewGuid().ToString() + "_" + fileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);

                imageFile.SaveAs(filePath);
                model.image_url = "/Template/img/products/" + uniqueFileName;
            }
            else
            {
                // Mantener la imagen actual si no se subió una nueva
                using (var dbTemp = new Espiga_DBEntities())
                {
                    var prod = dbTemp.products.AsNoTracking().FirstOrDefault(pr => pr.product_id == model.product_id);
                    if (prod != null)
                    {
                        model.image_url = prod.image_url;
                    }
                }
            }

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

                // Actualizar el precio de unidad
                db.Database.ExecuteSqlCommand(
                    @"UPDATE core.products SET unit_price = @p0 WHERE product_id = @p1", 
                    model.unit_price, 
                    model.product_id
                );

                // Actualizar el stock
                var stock = db.inventory_stock.FirstOrDefault(s => s.product_id == model.product_id);
                if (stock != null)
                {
                    stock.qty_available = model.qty_available;
                    stock.modified_by = user;
                    stock.modified_at = System.DateTime.Now;
                    stock.action = "Update Stock";
                }
                else
                {
                    db.inventory_stock.Add(new inventory_stock
                    {
                        product_id = model.product_id,
                        qty_available = model.qty_available,
                        created_by = user,
                        created_at = System.DateTime.Now,
                        action = "Initial Stock"
                    });
                }
                db.SaveChanges();
            }

            TempData["Success"] = "Producto actualizado correctamente ✏️";
            return RedirectToAction("Index");
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






