using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class UserModel
    {
        public int User_id { get; set; }

        public int Role_id { get; set; }

        public string Identification { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public int Is_Active { get; set; }
    }
}