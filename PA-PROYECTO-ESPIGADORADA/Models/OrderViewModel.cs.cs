using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class OrderDetailViewModel
    {
        [Required]
        public int product_id { get; set; }

        [Required]
        public int quantity { get; set; }

        [Required]
        public decimal unit_cost { get; set; }
    }

    public class OrderViewModel
    {
        [Required(ErrorMessage = "Seleccione un proveedor")]
        public int supplier_id { get; set; }

        public List<OrderDetailViewModel> details { get; set; } = new List<OrderDetailViewModel>();
    }
}

