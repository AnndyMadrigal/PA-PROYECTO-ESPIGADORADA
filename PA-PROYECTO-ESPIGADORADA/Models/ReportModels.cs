using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class ReportFilterViewModel
    {
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }
        public string TipoReporte { get; set; }
        public int? CategoriaId { get; set; }
    }

    // ── Ventas ───────────────────────────────────────────────────────
    public class ReporteVentasViewModel
    {
        public ReportFilterViewModel Filtro { get; set; }
        public List<FilaVenta> Filas { get; set; }
        public decimal TotalVentas { get; set; }
        public decimal TotalImpuesto { get; set; }
        public decimal TotalDescuento { get; set; }
        public string CurrencySymbol { get; set; }
    }

    public class FilaVenta
    {
        public string NumeroFactura { get; set; }
        public DateTime Fecha { get; set; }
        public string Cliente { get; set; }
        public string MetodoPago { get; set; }
        public decimal Subtotal { get; set; }
        public decimal Descuento { get; set; }
        public decimal Impuesto { get; set; }
        public decimal Total { get; set; }
        public string Estado { get; set; }
    }

    // ── Inventario ───────────────────────────────────────────────────
    public class ReporteInventarioViewModel
    {
        public ReportFilterViewModel Filtro { get; set; }
        public List<FilaInventario> Filas { get; set; }
        public string CurrencySymbol { get; set; }
    }

    public class FilaInventario
    {
        public string SKU { get; set; }
        public string Nombre { get; set; }
        public string Categoria { get; set; }
        public decimal Disponible { get; set; }
        public decimal StockMinimo { get; set; }
        public decimal PrecioUnidad { get; set; }
        public decimal ValorTotal { get; set; }
        public bool BajoStock { get; set; }
    }

    // ── Compras ──────────────────────────────────────────────────────
    public class ReporteComprasViewModel
    {
        public ReportFilterViewModel Filtro { get; set; }
        public List<FilaCompra> Filas { get; set; }
        public decimal TotalCompras { get; set; }
        public string CurrencySymbol { get; set; }
    }

    public class FilaCompra
    {
        public string NumeroFactura { get; set; }
        public DateTime Fecha { get; set; }
        public string Proveedor { get; set; }
        public decimal Subtotal { get; set; }
        public decimal Impuesto { get; set; }
        public decimal Total { get; set; }
        public string Estado { get; set; }
        public DateTime FechaVence { get; set; }
    }
}
