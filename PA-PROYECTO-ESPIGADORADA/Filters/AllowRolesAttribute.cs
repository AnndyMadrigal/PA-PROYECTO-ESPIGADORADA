using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;

namespace PA_PROYECTO_ESPIGADORADA.Filters
{
    public class AllowRolesAttribute : ActionFilterAttribute
    {
        private readonly int[] _roles;

        public AllowRolesAttribute(params int[] roles)
        {
            _roles = roles;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var session = filterContext.HttpContext.Session;

            if (session["Role_ID"] == null || !_roles.Contains((int)session["Role_ID"]))
            {
                filterContext.Result = new RedirectToRouteResult(
                    new System.Web.Routing.RouteValueDictionary(new
                    {
                        controller = "Home",
                        action = "Index"
                    })
                );
            }

            base.OnActionExecuting(filterContext);
        }
    }
}