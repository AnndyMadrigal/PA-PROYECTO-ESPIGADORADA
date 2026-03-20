using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;
using PA_PROYECTO_ESPIGADORADA.Services;
using PA_PROYECTO_ESPIGADORADA.Filters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web.Mvc;


namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class HomeController : BaseController
    {

        readonly Generals generals = new Generals();

        [ActiveSession]
        #region Index
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        #endregion 

        #region LOGIN
        [HttpGet]
        public ActionResult Login()
        {
            ViewBag.Message = "Página de Inicio de Sesión";

            return View();
        }

        [HttpPost]
        public ActionResult Login(UserModel model)
        {
            using (var context = new Espiga_DBEntities())
            {
                var result = context.LoginUser(model.Email, model.Password).FirstOrDefault();

                if (result == null)
                {
                    ViewBag.Mensaje = "Su información no se autenticó correctamente.";
                    return View();
                }

                Session["User_ID"] = result.user_id;
                Session["Role_ID"] = result.role_id;
                Session["Name"] = result.name;
                Session["Email"] = result.email;
                return RedirectToAction("Index", "Home");
            }
        }
        #endregion

        #region User Registration
        [HttpGet]
        public ActionResult Register()
        {
            ViewBag.Message = "Página de Registro";

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(UserModel model)
        {
            string currentUser = GetAuditUser();

            int clientRole = 3;

            using (var context = new Espiga_DBEntities())
            {

                var result = context.RegisterUser(clientRole, model.Identification, model.Name, model.Email, model.Password, currentUser);

                if (result <= 0)
                {
                    ViewBag.Mensaje = "Su información no se registró correctamente.";
                    return View();
                }

                return RedirectToAction("Login", "Home");
            }
        }
        #endregion

        #region Recover Password
        [HttpGet]
        public ActionResult RecoverPassword()
        {

            return View();
        }

        [HttpPost]
        public ActionResult RecoverPassword(UserModel model)
        {
            string currentUser = GetAuditUser();
            using (var context = new Espiga_DBEntities())
            {
                var result = context.ValidateEmail(model.Email).FirstOrDefault();

                if (result == null)
                {
                    ViewBag.Mensaje = "Su información no se validó correctamente.";
                    return View();
                }

                //Se genera la contraseña nueva
                var newPassword = generals.GeneratePassword();

                //Se actualiza la contraseña en la base de datos
                var update = context.UpdatePassword(newPassword, result.user_id, currentUser);

                if (update <= 0)
                {
                    ViewBag.Mensaje = "Su información no se actualizó correctamente.";
                    return View();
                }

                //Se envía un correo electrónico al usuario con la nueva contraseña
                string rutaHtml = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Template", "RecoverPassword.html");
                string htmlContent = System.IO.File.ReadAllText(rutaHtml);

                string finalHtml = htmlContent
                    .Replace("{{USER_NAME}}", result.name)
                    .Replace("{{NEW_PASSWORD}}", newPassword);

                generals.SendEmail(result.email, "Recuperar Acceso", finalHtml);
                return RedirectToAction("Login", "Home");
            }
        }
        #endregion

        #region Logout
        [ActiveSession]
        [HttpGet]
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login", "Home");
        }
        #endregion
    }
}