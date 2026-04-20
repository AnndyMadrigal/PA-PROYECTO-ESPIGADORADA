using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class ProvidersModel
    {
        public int Supplier_Id{ get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public byte Is_Active { get; set; }
    }
}