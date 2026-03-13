using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;
using System.IO;
using System;
using System.Collections.Generic;
using System.Linq;
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
        public ActionResult Login(string username, string password)
        {
            if (username == "admin" && password == "123")
            {
                return RedirectToAction("Index", "Home");
            }

            ViewBag.Error = "Usuario o contraseña incorrectos";
            return View();
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
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