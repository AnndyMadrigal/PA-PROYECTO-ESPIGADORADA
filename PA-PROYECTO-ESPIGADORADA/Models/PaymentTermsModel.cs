namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class PaymentTermsModel
    {
        public int TermId { get; set; }

        [Required(ErrorMessage = "El nombre del término es requerido")]
        [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
        [Display(Name = "Nombre del término")]
        public string TermName { get; set; }

        [Required(ErrorMessage = "Los días de vencimiento son requeridos")]
        [Range(0, 9999, ErrorMessage = "Los días deben ser mayores o iguales a 0")]
        [Display(Name = "Días de vencimiento")]
        public int? DaysDue { get; set; }
    }
}