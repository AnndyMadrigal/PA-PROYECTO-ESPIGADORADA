namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class ProductViewModel
    {
        public int product_id { get; set; }
        public string product_name { get; set; }
        public string sku { get; set; }
        public string description { get; set; }
        public string image_url { get; set; }
        public int category_id { get; set; }
        public string unit_of_measure { get; set; }
        public decimal min_stock { get; set; }
        public decimal unit_price { get; set; }
        public int tax_id { get; set; }
        public int is_active { get; set; }
    }
}

