namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class ShoppingCartItem
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ImageUrl { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal AvailableStock { get; set; }

        public decimal Subtotal => UnitPrice * Quantity;
        public decimal Tax => Subtotal * 0.13m; // 13% de IVA
        public decimal Total => Subtotal + Tax;
    }
}