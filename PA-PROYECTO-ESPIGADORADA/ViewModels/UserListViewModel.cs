using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class UserListViewModel
    {
        public int user_id { get; set; }
        public int role_id { get; set; }
        public string identification { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public int is_active { get; set; }
        public string action { get; set; }
    }
}