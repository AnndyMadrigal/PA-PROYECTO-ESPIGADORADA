using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class SettingsModel
    {
        public int SettingId { get; set; }

        [Required(ErrorMessage = "El nombre de la empresa es obligatorio.")]
        [Display(Name = "Nombre de la empresa")]
        public string CompanyName { get; set; }

        [Required(ErrorMessage = "El símbolo de moneda es obligatorio.")]
        [StringLength(5, ErrorMessage = "Máximo 5 caracteres.")]
        [Display(Name = "Símbolo de moneda")]
        public string CurrencySymbol { get; set; }

        [Required(ErrorMessage = "El correo de soporte es obligatorio.")]
        [EmailAddress(ErrorMessage = "Ingrese un correo válido.")]
        [Display(Name = "Correo de soporte")]
        public string SupportEmail { get; set; }

        [Range(0, 100000, ErrorMessage = "Ingrese un valor válido.")]
        [Display(Name = "Umbral de stock bajo")]
        public int LowStockThreshold { get; set; }
    }
}