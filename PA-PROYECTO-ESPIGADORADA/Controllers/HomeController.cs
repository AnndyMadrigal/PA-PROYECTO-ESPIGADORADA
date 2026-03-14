using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Login()
        {
            ViewBag.Message = "Login Page";

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
                Session["Name"] = result.name;
                Session["Email"] = result.email;
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public ActionResult Register(UserModel model)
        {
            using (var context = new Espiga_DBEntities())
            { 
            var result = context.RegisterUser(model.Identification, model.Name, model.Email, model.Password);

            if (result <= 0)
            {
                ViewBag.Mensaje = "Su información no se registró correctamente.";
                return View();
            }

            return RedirectToAction("Login", "Home");
        }
        }
        [HttpGet]
        public ActionResult RecoverPassword()
        {
            
            return View();
        }
    }
}