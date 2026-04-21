using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class CheckoutViewModel
    {
        public CheckoutViewModel()
        {
            Items = new List<ShoppingCartItem>();
            PaymentMethods = new List<SelectListItem>();
        }

        public List<ShoppingCartItem> Items { get; set; }
        public List<SelectListItem> PaymentMethods { get; set; }

        [Display(Name = "Confirmo que deseo realizar la compra")]
        public bool ConfirmPurchase { get; set; }

        [Required(ErrorMessage = "Debe seleccionar un método de pago.")]
        [Display(Name = "Método de pago")]
        [StringLength(30)]
        public string PaymentMethod { get; set; }

        [Display(Name = "Referencia de pago")]
        [StringLength(80)]
        public string PaymentReference { get; set; }

        [Display(Name = "Notas")]
        [StringLength(250)]
        public string Notes { get; set; }

        public decimal Subtotal
        {
            get { return Items != null ? Items.Sum(i => i.Subtotal) : 0; }
        }

        public decimal DiscountTotal
        {
            get { return 0; }
        }

        public decimal TaxTotal
        {
            get { return Items != null ? Items.Sum(i => i.Tax) : 0; }
        }

        public decimal Total
        {
            get { return Items != null ? Items.Sum(i => i.Total) : 0; }
        }
    }
}
