
using System.Collections.Generic;
using System.Web;
using System;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Filters;
using PA_PROYECTO_ESPIGADORADA.Models;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    [AllowRoles(1, 2)]
    public class ReportsController : BaseController
    {
        // ─────────────────────────────────────────────────────────────
        // PANTALLA DE FILTROS
        // ─────────────────────────────────────────────────────────────
        public ActionResult Index()
        {
            CargarCategorias();
            return View(new ReportFilterViewModel
            {
                FechaInicio = DateTime.Today.AddMonths(-1),
                FechaFin = DateTime.Today
            });
        }

        [HttpPost]
        public ActionResult Index(ReportFilterViewModel filtro)
        {
            CargarCategorias();
            using (var db = new Espiga_DBEntities())
            {
                string curr = ObtenerMoneda(db);
                switch (filtro.TipoReporte)
                {
                    case "ventas":
                        return View("ReporteVentas", BuildVentas(db, filtro, curr));
                    case "inventario":
                        return View("ReporteInventario", BuildInventario(db, filtro, curr));
                    case "compras":
                        return View("ReporteCompras", BuildCompras(db, filtro, curr));
                    default:
                        ModelState.AddModelError("", "Seleccione un tipo de reporte.");
                        return View(filtro);
                }
            }
        }

        // ─────────────────────────────────────────────────────────────
        // RF-018 — EXPORTAR PDF
        // ─────────────────────────────────────────────────────────────
        public ActionResult ExportarPDF(string tipo, DateTime? inicio,
                                        DateTime? fin, int? categoriaId)
        {
            var filtro = new ReportFilterViewModel
            {
                TipoReporte = tipo,
                FechaInicio = inicio ?? DateTime.Today.AddMonths(-1),
                FechaFin = fin ?? DateTime.Today,
                CategoriaId = categoriaId
            };

            using (var db = new Espiga_DBEntities())
            {
                string curr = ObtenerMoneda(db);
                using (var ms = new MemoryStream())
                {
                    var doc = new Document(PageSize.A4.Rotate(), 20f, 20f, 30f, 20f);
                    PdfWriter.GetInstance(doc, ms);
                    doc.Open();

                    // Fuentes
                    var fTit = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.DARK_GRAY);
                    var fSub = FontFactory.GetFont(FontFactory.HELVETICA, 8, BaseColor.GRAY);
                    var fHead = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 9, BaseColor.WHITE);
                    var fCell = FontFactory.GetFont(FontFactory.HELVETICA, 8, BaseColor.BLACK);
                    var fTot = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 9, BaseColor.DARK_GRAY);
                    var brown = new BaseColor(121, 85, 72);

                    // Encabezado del documento
                    doc.Add(new Paragraph("Espiga Dorada — Reporte de " + ToTitle(tipo), fTit));
                    doc.Add(new Paragraph(
                        $"Período: {filtro.FechaInicio:dd/MM/yyyy} – {filtro.FechaFin:dd/MM/yyyy}" +
                        $"   |   Generado: {DateTime.Now:dd/MM/yyyy HH:mm}", fSub));
                    doc.Add(Chunk.NEWLINE);

                    if (tipo == "ventas")
                    {
                        var m = BuildVentas(db, filtro, curr);
                        var t = NuevaTabla(9);
                        Encabezados(t, brown, fHead, "# Factura", "Fecha", "Cliente",
                            "Método pago", "Subtotal", "Descuento", "Impuesto", "Total", "Estado");
                        foreach (var r in m.Filas)
                        {
                            t.AddCell(Celda(r.NumeroFactura, fCell));
                            t.AddCell(Celda(r.Fecha.ToString("dd/MM/yyyy"), fCell));
                            t.AddCell(Celda(r.Cliente, fCell));
                            t.AddCell(Celda(r.MetodoPago, fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Subtotal:N2}", fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Descuento:N2}", fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Impuesto:N2}", fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Total:N2}", fCell));
                            t.AddCell(Celda(r.Estado, fCell));
                        }
                        doc.Add(t);
                        doc.Add(Chunk.NEWLINE);
                        doc.Add(new Paragraph(
                            $"TOTAL VENTAS: {curr}{m.TotalVentas:N2}   " +
                            $"|   IMPUESTOS: {curr}{m.TotalImpuesto:N2}", fTot));
                    }
                    else if (tipo == "inventario")
                    {
                        var m = BuildInventario(db, filtro, curr);
                        var t = NuevaTabla(8);
                        Encabezados(t, brown, fHead, "SKU", "Producto", "Categoría",
                            "Disponible", "Stock mín.", "Precio unit.", "Valor total", "Estado");
                        foreach (var r in m.Filas)
                        {
                            t.AddCell(Celda(r.SKU, fCell));
                            t.AddCell(Celda(r.Nombre, fCell));
                            t.AddCell(Celda(r.Categoria, fCell));
                            t.AddCell(CeldaDer(r.Disponible.ToString("N2"), fCell));
                            t.AddCell(CeldaDer(r.StockMinimo.ToString("N2"), fCell));
                            t.AddCell(CeldaDer($"{curr}{r.PrecioUnidad:N2}", fCell));
                            t.AddCell(CeldaDer($"{curr}{r.ValorTotal:N2}", fCell));
                            t.AddCell(new PdfPCell(new Phrase(
                                r.BajoStock ? "Bajo stock" : "OK",
                                FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 8,
                                    r.BajoStock ? BaseColor.RED : new BaseColor(0, 128, 0))))
                            { Padding = 4 });
                        }
                        doc.Add(t);
                    }
                    else
                    {
                        var m = BuildCompras(db, filtro, curr);
                        var t = NuevaTabla(8);
                        Encabezados(t, brown, fHead, "# Factura", "Fecha", "Proveedor",
                            "Subtotal", "Impuesto", "Total", "Vence", "Estado");
                        foreach (var r in m.Filas)
                        {
                            t.AddCell(Celda(r.NumeroFactura, fCell));
                            t.AddCell(Celda(r.Fecha.ToString("dd/MM/yyyy"), fCell));
                            t.AddCell(Celda(r.Proveedor, fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Subtotal:N2}", fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Impuesto:N2}", fCell));
                            t.AddCell(CeldaDer($"{curr}{r.Total:N2}", fCell));
                            t.AddCell(Celda(r.FechaVence.ToString("dd/MM/yyyy"), fCell));
                            t.AddCell(Celda(r.Estado, fCell));
                        }
                        doc.Add(t);
                        doc.Add(Chunk.NEWLINE);
                        doc.Add(new Paragraph($"TOTAL COMPRAS: {curr}{m.TotalCompras:N2}", fTot));
                    }

                    doc.Close();
                    return File(ms.ToArray(), "application/pdf",
                        $"Reporte_{tipo}_{DateTime.Now:yyyyMMdd_HHmm}.pdf");
                }
            }
        }

        // ─────────────────────────────────────────────────────────────
        // RF-018 — EXPORTAR EXCEL
        // ─────────────────────────────────────────────────────────────
        public ActionResult ExportarExcel(string tipo, DateTime? inicio,
                                          DateTime? fin, int? categoriaId)
        {
            var filtro = new ReportFilterViewModel
            {
                TipoReporte = tipo,
                FechaInicio = inicio ?? DateTime.Today.AddMonths(-1),
                FechaFin = fin ?? DateTime.Today,
                CategoriaId = categoriaId
            };

            using (var db = new Espiga_DBEntities())
            {
                string curr = ObtenerMoneda(db);
                var brown = System.Drawing.Color.FromArgb(121, 85, 72);

                using (var pck = new ExcelPackage())
                {
                    var ws = pck.Workbook.Worksheets.Add(ToTitle(tipo));

                    if (tipo == "ventas")
                    {
                        var m = BuildVentas(db, filtro, curr);
                        XlsEncabezado(ws, brown, "# Factura", "Fecha", "Cliente",
                            "Método pago", "Subtotal", "Descuento", "Impuesto", "Total", "Estado");
                        int fila = 2;
                        foreach (var r in m.Filas)
                        {
                            ws.Cells[fila, 1].Value = r.NumeroFactura;
                            ws.Cells[fila, 2].Value = r.Fecha;
                            ws.Cells[fila, 2].Style.Numberformat.Format = "dd/mm/yyyy";
                            ws.Cells[fila, 3].Value = r.Cliente;
                            ws.Cells[fila, 4].Value = r.MetodoPago;
                            ws.Cells[fila, 5].Value = r.Subtotal;
                            ws.Cells[fila, 6].Value = r.Descuento;
                            ws.Cells[fila, 7].Value = r.Impuesto;
                            ws.Cells[fila, 8].Value = r.Total;
                            ws.Cells[fila, 9].Value = r.Estado;
                            fila++;
                        }
                        ws.Cells[fila, 7].Value = "TOTAL:";
                        ws.Cells[fila, 7].Style.Font.Bold = true;
                        ws.Cells[fila, 8].Value = m.TotalVentas;
                        ws.Cells[fila, 8].Style.Font.Bold = true;
                        XlsMoneda(ws, new[] { 5, 6, 7, 8 }, 2, fila);
                    }
                    else if (tipo == "inventario")
                    {
                        var m = BuildInventario(db, filtro, curr);
                        XlsEncabezado(ws, brown, "SKU", "Producto", "Categoría",
                            "Disponible", "Stock mín.", "Precio unit.", "Valor total", "Estado");
                        int fila = 2;
                        foreach (var r in m.Filas)
                        {
                            ws.Cells[fila, 1].Value = r.SKU;
                            ws.Cells[fila, 2].Value = r.Nombre;
                            ws.Cells[fila, 3].Value = r.Categoria;
                            ws.Cells[fila, 4].Value = r.Disponible;
                            ws.Cells[fila, 5].Value = r.StockMinimo;
                            ws.Cells[fila, 6].Value = r.PrecioUnidad;
                            ws.Cells[fila, 7].Value = r.ValorTotal;
                            ws.Cells[fila, 8].Value = r.BajoStock ? "Bajo stock" : "OK";
                            if (r.BajoStock)
                                ws.Cells[fila, 8].Style.Font.Color
                                  .SetColor(System.Drawing.Color.Red);
                            fila++;
                        }
                        XlsMoneda(ws, new[] { 6, 7 }, 2, m.Filas.Count + 1);
                    }
                    else
                    {
                        var m = BuildCompras(db, filtro, curr);
                        XlsEncabezado(ws, brown, "# Factura", "Fecha", "Proveedor",
                            "Subtotal", "Impuesto", "Total", "Vence", "Estado");
                        int fila = 2;
                        foreach (var r in m.Filas)
                        {
                            ws.Cells[fila, 1].Value = r.NumeroFactura;
                            ws.Cells[fila, 2].Value = r.Fecha;
                            ws.Cells[fila, 2].Style.Numberformat.Format = "dd/mm/yyyy";
                            ws.Cells[fila, 3].Value = r.Proveedor;
                            ws.Cells[fila, 4].Value = r.Subtotal;
                            ws.Cells[fila, 5].Value = r.Impuesto;
                            ws.Cells[fila, 6].Value = r.Total;
                            ws.Cells[fila, 7].Value = r.FechaVence;
                            ws.Cells[fila, 7].Style.Numberformat.Format = "dd/mm/yyyy";
                            ws.Cells[fila, 8].Value = r.Estado;
                            fila++;
                        }
                        ws.Cells[fila, 5].Value = "TOTAL:";
                        ws.Cells[fila, 5].Style.Font.Bold = true;
                        ws.Cells[fila, 6].Value = m.TotalCompras;
                        ws.Cells[fila, 6].Style.Font.Bold = true;
                        XlsMoneda(ws, new[] { 4, 5, 6 }, 2, fila);
                    }

                    ws.Cells[ws.Dimension.Address].AutoFitColumns();
                    return File(pck.GetAsByteArray(),
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                        $"Reporte_{tipo}_{DateTime.Now:yyyyMMdd_HHmm}.xlsx");
                }
            }
        }

        // ─────────────────────────────────────────────────────────────
        // BUILDERS DE DATOS
        // ─────────────────────────────────────────────────────────────
        private ReporteVentasViewModel BuildVentas(Espiga_DBEntities db,
            ReportFilterViewModel f, string curr)
        {
            var fin = (f.FechaFin ?? DateTime.Today).AddDays(1);
            var filas = db.sales_invoices
                .Where(s => s.sales_datetime >= f.FechaInicio &&
                            s.sales_datetime < fin)
                .OrderByDescending(s => s.sales_datetime)
                .ToList()
                .Select(s => new FilaVenta
                {
                    NumeroFactura = s.sales_number ?? "-",
                    Fecha = s.sales_datetime,
                    Cliente = s.users != null ? s.users.name : "—",
                    MetodoPago = s.payment_method ?? "—",
                    Subtotal = s.subtotal,
                    Descuento = s.discount_total,
                    Impuesto = s.tax_total,
                    Total = s.total,
                    Estado = s.status
                }).ToList();

            return new ReporteVentasViewModel
            {
                Filtro = f,
                Filas = filas,
                TotalVentas = filas.Sum(x => x.Total),
                TotalImpuesto = filas.Sum(x => x.Impuesto),
                TotalDescuento = filas.Sum(x => x.Descuento),
                CurrencySymbol = curr
            };
        }

        private ReporteInventarioViewModel BuildInventario(Espiga_DBEntities db,
            ReportFilterViewModel f, string curr)
        {
            var filas = db.inventory_stock
                .Where(i => i.products.is_active == 1 &&
                    (f.CategoriaId == null ||
                     i.products.category_id == f.CategoriaId))
                .ToList()
                .Select(i => new FilaInventario
                {
                    SKU = i.products.sku ?? "-",
                    Nombre = i.products.product_name,
                    Categoria = i.products.product_categories != null
                                   ? i.products.product_categories.category_name : "—",
                    Disponible = i.qty_available,
                    StockMinimo = i.products.min_stock,
                    PrecioUnidad = i.products.unit_price,
                    ValorTotal = i.qty_available * i.products.unit_price,
                    BajoStock = i.qty_available <= i.products.min_stock
                }).ToList();

            return new ReporteInventarioViewModel
            { Filtro = f, Filas = filas, CurrencySymbol = curr };
        }

        private ReporteComprasViewModel BuildCompras(Espiga_DBEntities db,
            ReportFilterViewModel f, string curr)
        {
            var fin = (f.FechaFin ?? DateTime.Today).AddDays(1);
            var filas = db.purchase_invoices
                .Where(p => p.invoice_date >= f.FechaInicio &&
                            p.invoice_date < fin)
                .OrderByDescending(p => p.invoice_date)
                .ToList()
                .Select(p => new FilaCompra
                {
                    NumeroFactura = p.invoice_number,
                    Fecha = p.invoice_date,
                    Proveedor = p.suppliers != null ? p.suppliers.name : "—",
                    Subtotal = p.subtotal,
                    Impuesto = p.tax_total,
                    Total = p.total,
                    Estado = p.status,
                    FechaVence = p.due_date
                }).ToList();

            return new ReporteComprasViewModel
            {
                Filtro = f,
                Filas = filas,
                TotalCompras = filas.Sum(x => x.Total),
                CurrencySymbol = curr
            };
        }

        // ─────────────────────────────────────────────────────────────
        // HELPERS COMPARTIDOS
        // ─────────────────────────────────────────────────────────────
        private void CargarCategorias()
        {
            using (var db = new Espiga_DBEntities())
                ViewBag.Categorias = db.product_categories
                    .Where(c => c.is_active == 1)
                    .Select(c => new SelectListItem
                    {
                        Value = c.category_id.ToString(),
                        Text = c.category_name
                    }).ToList();
        }

        private string ObtenerMoneda(Espiga_DBEntities db) =>
            db.settings.FirstOrDefault()?.currency_symbol ?? "¢";

        private string ToTitle(string tipo) =>
            tipo == "ventas" ? "Ventas" :
            tipo == "inventario" ? "Inventario" : "Compras";

        // PDF
        private PdfPTable NuevaTabla(int cols)
        {
            var t = new PdfPTable(cols) { WidthPercentage = 100 };
            t.DefaultCell.Padding = 4;
            return t;
        }
        private void Encabezados(PdfPTable t, BaseColor bg, Font f,
            params string[] headers)
        {
            foreach (var h in headers)
                t.AddCell(new PdfPCell(new Phrase(h, f))
                {
                    BackgroundColor = bg,
                    HorizontalAlignment = Element.ALIGN_CENTER,
                    Padding = 5
                });
        }
        private PdfPCell Celda(string txt, Font f) =>
            new PdfPCell(new Phrase(txt ?? "", f)) { Padding = 4 };
        private PdfPCell CeldaDer(string txt, Font f) =>
            new PdfPCell(new Phrase(txt ?? "", f))
            { HorizontalAlignment = Element.ALIGN_RIGHT, Padding = 4 };

        // Excel
        private void XlsEncabezado(ExcelWorksheet ws,
            System.Drawing.Color bg, params string[] headers)
        {
            for (int i = 0; i < headers.Length; i++)
            {
                var c = ws.Cells[1, i + 1];
                c.Value = headers[i];
                c.Style.Font.Bold = true;
                c.Style.Font.Color.SetColor(System.Drawing.Color.White);
                c.Style.Fill.PatternType = ExcelFillStyle.Solid;
                c.Style.Fill.BackgroundColor.SetColor(bg);
                c.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            }
        }
        private void XlsMoneda(ExcelWorksheet ws, int[] cols, int inicio, int fin)
        {
            foreach (var c in cols)
                ws.Cells[inicio, c, fin, c]
                  .Style.Numberformat.Format = "#,##0.00";
        }
    }
}