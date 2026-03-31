/*
using PA_PROYECTO_ESPIGADORADA.EntityFramework;
using PA_PROYECTO_ESPIGADORADA.Models;
using PA_PROYECTO_ESPIGADORADA.Filters;
using System.Linq;
using System.Web.Mvc;
using System;
using PA_PROYECTO_ESPIGADORADA.Services;
using System.Data.Entity;

namespace PA_PROYECTO_ESPIGADORADA.Controllers
{
    [ActiveSession]
    [AllowRoles(2, 3)]
    public class UsersController : BaseController
    {
        readonly Generals generals = new Generals();

        [HttpGet]
        public ActionResult ConsultUsers()
        {
            using (var context = new Espiga_DBEntities())
            {
                var users = context.users.Where(u => u.role_id == 3).ToList();
                return View(users);
            }
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View(new UserModel());
        }

        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(UserModel model)
        {
            if (ModelState.IsValid)
            {
                string currentUser = GetAuditUser();
                using (var context = new Espiga_DBEntities())
                {
                    //asignamos el role_id = 3(app_user) por defecto según los roles existentes.
                    var result = context.RegisterUser(3, model.Identification, model.Name, model.Email, model.Password, currentUser);
                    if (result > 0)
                    {
                        return RedirectToAction("ConsultUsers");
                    }
                    ViewBag.Mensaje = "Ocurrió un error al registrar el usuario.";
                }
            }
            return View(model);
        }

        
        [HttpGet]
        public ActionResult Edit(int id)
        {
            using (var context = new Espiga_DBEntities())
            {
                // Reemplazamos el .Where() por el llamado al SP
                var user = context.GetUserById(id).FirstOrDefault();

                if (user == null)
                {
                    return HttpNotFound();
                }

                var model = new UserModel
                {
                    User_id = user.user_id,
                    Identification = user.identification,
                    Name = user.name,
                    Email = user.email,
                    Is_Active = user.is_active
                };

                return View(model);
            }
        }

        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(UserModel model)
        {
            if (ModelState.IsValid)
            {
                string currentUser = GetAuditUser();
                using (var context = new Espiga_DBEntities())
                {
                    
                    context.UpdateUser(model.User_id, model.Identification, model.Name, model.Email, currentUser);

                    //si el usuario digitó una contraseña nueva, ejecutamos el SP
                    if (!string.IsNullOrEmpty(model.Password))
                    {
                        context.UpdatePassword(model.Password, model.User_id, currentUser);
                    }

                    return RedirectToAction("ConsultUsers");
                }
            }
            return View(model);
        }

        // POST: Users/ToggleStatus
        [HttpPost]
        public ActionResult ToggleStatus(int id)
        {
            string currentUser = GetAuditUser();
            using (var context = new Espiga_DBEntities())
            {
                var user = context.users.Where(p => p.user_id == id).FirstOrDefault();
                if (user != null)
                {
                    user.is_active = (byte)(user.is_active == 1 ? 0 : 1);
                    user.modified_by = currentUser;
                    user.modified_at = DateTime.Now;

                    context.SaveChanges();
                }
            }
            return RedirectToAction("ConsultUsers");
        }





        [HttpGet]
        public ActionResult ConsultUsers()
        {
            using (var context = new Espiga_DBEntities())
            {
                var users = context.GetSystemUsers()
                    .Select(u => new UserListViewModel
                    {
                        user_id = u.user_id,
                        role_id = u.role_id,
                        identification = u.identification,
                        name = u.name,
                        email = u.email,
                        is_active = u.is_active,
                        action = u.action
                    })
                    .ToList();

                return View(users);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            string currentUser = GetAuditUser();

            using (var context = new Espiga_DBEntities())
            {
                var result = context.DeleteUserLogical(id, currentUser).FirstOrDefault();

                if (result == null || result.Code == 0)
                {
                    TempData["Mensaje"] = result != null ? result.Message : "Ocurrió un error al eliminar el usuario.";
                }
            }

            return RedirectToAction("ConsultUsers");
        }

    }
}
*/