using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Filters;
using PA_PROYECTO_ESPIGADORADA.Models;
using PA_PROYECTO_ESPIGADORADA.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    public class ProvidersController : BaseController
    {
        readonly Generals generals = new Generals();
        [HttpGet]
        public ActionResult ConsultProviders()
        {
            using (var context = new Espiga_DBEntities())
            {
                var providers = context.suppliers.ToList();

                var providersModel = providers.Select(c => new Models.ProvidersModel
                {
                    Supplier_Id = c.supplier_id,
                    Name = c.name,
                    Email = c.email,
                    Phone = c.phone,
                    Is_Active = c.is_active

                }).OrderBy(c => c.Is_Active != 0).ToList();
                return View(providersModel);
            }
        }
        [HttpGet]
        public ActionResult EditProvider(int id)
        {
            using (var context = new Espiga_DBEntities())
            {
                var supplier = context.suppliers.FirstOrDefault(s => s.supplier_id == id);

                if (supplier == null)
                {
                    return HttpNotFound();
                }

                var model = new ProvidersModel
                {
                    Supplier_Id = supplier.supplier_id,
                    Name = supplier.name,
                    Email = supplier.email,
                    Phone = supplier.phone,
                    Is_Active = supplier.is_active
                };

                return View(model);
            }
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProvider(ProvidersModel model)
        {
            if (ModelState.IsValid)
            {
                string currentUser = GetAuditUser();
                using (var context = new Espiga_DBEntities())
                {
                    var supplier = context.suppliers.FirstOrDefault(s => s.supplier_id == model.Supplier_Id);
                    if (supplier != null)
                    {
                        supplier.name = model.Name;
                        supplier.email = model.Email;
                        supplier.phone = model.Phone;
                        supplier.modified_by = currentUser;
                        supplier.modified_at = DateTime.Now;

                        context.SaveChanges();
                    }

                    return RedirectToAction("ConsultProviders");
                }
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult RegisterProvider()
        {
            return View();
        }
            [HttpPost]
        public ActionResult RegisterProvider(ProvidersModel model)
        {
            if (ModelState.IsValid)
            {
                string currentUser = GetAuditUser();
                using (var context = new Espiga_DBEntities())
                {
                    var newSupplier = new suppliers
                    {
                        name = model.Name,
                        email = model.Email,
                        phone = model.Phone,
                        is_active = 1,
                        created_by = currentUser,
                        created_at = DateTime.Now
                    };

                    context.suppliers.Add(newSupplier);
                    var result = context.SaveChanges();

                    if (result > 0)
                    {
                        return RedirectToAction("ConsultProviders");
                    }
                    ViewBag.Mensaje = "Ocurrió un error al registrar el proveedor.";
                }
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult ToggleStatus(int id)
        {
            string currentUser = GetAuditUser();
            using (var context = new Espiga_DBEntities())
            {
                var supplier = context.suppliers.Where(p => p.supplier_id == id).FirstOrDefault();
                if ( supplier != null)
                {
                    supplier.is_active = (byte)(supplier.is_active == 1 ? 0 : 1);
                    supplier.modified_by = currentUser;
                    supplier.modified_at = DateTime.Now;

                    context.SaveChanges();
                }
            }
            return RedirectToAction("ConsultProviders");
        }
    }
}