using System;
using System.Linq;
using System.Web.Mvc;
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;
using PA_PROYECTO_ESPIGADORADA.Filters;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    [AllowRoles(1, 2)]
    public class DashboardController : Controller
    {
        public ActionResult Index()
        {
            using (var context = new Espiga_DBEntities())
            {
                var today = DateTime.Today;

                // Obtener configuración general
                var setting = context.settings.FirstOrDefault();
                int lowStockThreshold = setting != null ? setting.low_stock_threshold : 5;
                string currencySymbol = setting != null && !string.IsNullOrEmpty(setting.currency_symbol)
                    ? setting.currency_symbol
                    : "₡";

                // Construcción del modelo
                var model = new DashboardModel
                {
                    VentasHoy = context.sales_invoices
                        .Where(x => x.sales_datetime >= today)
                        .Sum(x => (decimal?)x.total) ?? 0,

                    ProductosStockBajo = context.inventory_stock
                        .Count(x => x.qty_available <= lowStockThreshold),

                    FacturasPorPagar = context.purchase_invoices
                        .Count(x => x.status == "PENDIENTE"),

                    TotalProductos = context.products.Count(),

                    CurrencySymbol = currencySymbol,
                    LowStockThreshold = lowStockThreshold
                };

                return View(model);
            }
        }
    }
}