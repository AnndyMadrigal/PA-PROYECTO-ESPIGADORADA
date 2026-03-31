using System.ComponentModel.DataAnnotations;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class ProductViewModel
    {
        public int product_id { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
        public string product_name { get; set; }

        [Required(ErrorMessage = "El SKU es obligatorio")]
        [StringLength(60, ErrorMessage = "Máximo 60 caracteres")]
        public string sku { get; set; }

        [StringLength(500)]
        public string description { get; set; }

        [StringLength(500)]
        public string image_url { get; set; }

        [Required(ErrorMessage = "Debe seleccionar una categoría")]
        public int category_id { get; set; }

        public string unit_of_measure { get; set; }

        [Required(ErrorMessage = "Debe ingresar el stock mínimo")]
        [Range(0, 999999, ErrorMessage = "El stock debe ser mayor o igual a 0")]
        public decimal min_stock { get; set; }

        [Required(ErrorMessage = "Debe seleccionar un impuesto")]
        public int tax_id { get; set; }

        public int is_active { get; set; }
    }
}

