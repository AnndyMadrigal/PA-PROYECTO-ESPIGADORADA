using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class BaseController : Controller
    {
        //metodo para obtener quién hace la acción
        protected string GetAuditUser()
        {
            if (Session["Name"] != null)
            {
                return Session["Name"].ToString();
            }
            return "Usuario_Desconocido";
        }
    }
}