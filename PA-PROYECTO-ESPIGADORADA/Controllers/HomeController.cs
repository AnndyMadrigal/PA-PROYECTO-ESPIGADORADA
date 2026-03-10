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
            ViewBag.Message = "Register Page";

            return View();
        }

        [HttpPost]
        public ActionResult Register(string username, string password, string confirmPassword)
        {
            if (password != confirmPassword)
            {
                ViewBag.Error = "Las contraseñas no coinciden";
                return View();
            }

            // aquí iría guardar en BD, de momento solo flujo
            return RedirectToAction("Index", "Login");
        }

        [HttpGet]
        public ActionResult RecoverPassword()
        {
            
            return View();
        }
    }
}