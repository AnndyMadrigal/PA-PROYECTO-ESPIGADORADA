using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    public class PaymentTermsController : Controller
    {

        [HttpGet]
        public ActionResult Registro(int? id)
        {
            if (id == null)
            {
                return View(new PaymentTermsModel());
            }

            using (var context = new Espiga_DBEntities())
            {
                var data = context.SP_AdministrarPaymentTerms(
                    "READ",
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null
                ).FirstOrDefault(x => x.TermId == id.Value);

                if (data == null || data.ActionValue == "D")
                {
                    TempData["Mensaje"] = "El término de pago no existe o está inactivo.";
                    TempData["Tipo"] = "danger";
                    return RedirectToAction("Consulta");
                }

                var model = new PaymentTermsModel
                {
                    TermId = data.TermId ?? 0,
                    TermName = data.TermName,
                    DaysDue = data.DaysDue ?? 0
                };

                return View(model);
            }
        }

        [HttpPost]
        public ActionResult Register(PaymentTermsModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            using (var context = new Espiga_DBEntities())
            {
                var usuario = Session["Usuario"] != null ? Session["Usuario"].ToString() : "system";

                var result = context.SP_AdministrarPaymentTerms(
                    model.TermId == 0 ? "INSERT" : "UPDATE",
                    model.TermId == 0 ? (int?)null : model.TermId,
                    model.TermName,
                    model.DaysDue,
                    model.TermId == 0 ? usuario : null,
                    model.TermId > 0 ? usuario : null,
                    null,
                    null,
                    null
                ).FirstOrDefault();

                if (result != null && result.Codigo == 1)
                {
                    TempData["Mensaje"] = result.Mensaje;
                    TempData["Tipo"] = "success";
                    return RedirectToAction("Consulta");
                }

                ViewBag.Mensaje = result != null ? result.Mensaje : "Error inesperado.";
                ViewBag.Tipo = "danger";
                return View(model);
            }
        }

        [HttpGet]
        public ActionResult Consulta()
        {
            using (var context = new Espiga_DBEntities())
            {
                var data = context.SP_AdministrarPaymentTerms(
                    "READ",
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null
                ).ToList();

                return View(data);
            }
        }

        [HttpPost]
        public ActionResult Eliminar(int id)
        {
            using (var context = new Espiga_DBEntities())
            {
                var usuario = Session["Usuario"] != null ? Session["Usuario"].ToString() : "system";

                var result = context.SP_AdministrarPaymentTerms(
                    "DELETE",
                    id,
                    null,
                    null,
                    null,
                    usuario,
                    null,
                    null,
                    null
                ).FirstOrDefault();

                TempData["Mensaje"] = result != null ? result.Mensaje : "Error inesperado.";
                TempData["Tipo"] = (result != null && result.Codigo == 1) ? "success" : "danger";

                return RedirectToAction("Consulta");
            }
        }

    }
}