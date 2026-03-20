using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;
using PA_PROYECTO_ESPIGADORADA.Services;
using PA_PROYECTO_ESPIGADORADA.Filters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    public class SecurityController : BaseController
    {
        readonly Generals generals = new Generals();
        [HttpGet]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ChangePassword(SecurityModel model)
        {
            if (!ModelState.IsValid)
                return View(model);
            string currentUser = GetAuditUser();
            using (var context = new Espiga_DBEntities())
            {
                var UserIdSession = int.Parse(Session["User_ID"].ToString());
                var update = context.UpdatePassword(model.NewPassword, UserIdSession, currentUser);

                if (update <= 0)
                {
                    ViewBag.Mensaje = "Su información no se actualizó correctamente.";
                    return View(model);
                }

                string htmlRoute = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Template", "NotifyPassword.html");
                string htmlContent = System.IO.File.ReadAllText(htmlRoute);

                string finalHtml = htmlContent
                    .Replace("{{USER_NAME}}", Session["Name"].ToString());

                generals.SendEmail(Session["Email"].ToString(), "Notificación de Acceso", finalHtml);

                return RedirectToAction("Logout", "Home");
            }
        }
    }
}