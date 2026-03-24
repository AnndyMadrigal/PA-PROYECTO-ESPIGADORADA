using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Filters;
using PA_PROYECTO_ESPIGADORADA.Models;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    [AllowRoles(1, 2)]
    public class SettingsController : BaseController
    {
        [HttpGet]
        public ActionResult Index()
        {
            using (var context = new Espiga_DBEntities())
            {
                var setting = context.settings.FirstOrDefault();

                var model = new SettingsModel();

                if (setting != null)
                {
                    model.SettingId = setting.setting_id;
                    model.CompanyName = setting.company_name;
                    model.CurrencySymbol = setting.currency_symbol;
                    model.SupportEmail = setting.support_email;
                    model.LowStockThreshold = setting.low_stock_threshold;
                }

                return View(model);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(SettingsModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            string currentUser = GetAuditUser();

            using (var context = new Espiga_DBEntities())
            {
                var setting = context.settings.FirstOrDefault();

                if (setting == null)
                {
                    setting = new settings
                    {
                        company_name = model.CompanyName,
                        currency_symbol = model.CurrencySymbol,
                        support_email = model.SupportEmail,
                        low_stock_threshold = model.LowStockThreshold,
                        created_by = currentUser
                    };

                    context.settings.Add(setting);
                }
                else
                {
                    setting.company_name = model.CompanyName;
                    setting.currency_symbol = model.CurrencySymbol;
                    setting.support_email = model.SupportEmail;
                    setting.low_stock_threshold = model.LowStockThreshold;
                    setting.modified_by = currentUser;
                }

                context.SaveChanges();
            }

            TempData["Mensaje"] = "La configuración general se guardó correctamente.";
            return RedirectToAction("Index");
        }
    }
}