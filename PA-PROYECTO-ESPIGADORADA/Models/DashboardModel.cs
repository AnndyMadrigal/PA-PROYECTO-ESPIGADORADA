namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class DashboardModel
    {
        public decimal VentasHoy { get; set; }
        public int ProductosStockBajo { get; set; }
        public int FacturasPorPagar { get; set; }
        public int TotalProductos { get; set; }

        public string CurrencySymbol { get; set; }
        public int LowStockThreshold { get; set; }
    }
}