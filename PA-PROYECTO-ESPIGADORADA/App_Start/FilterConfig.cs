using System.Web;
using System.Web.Mvc;

namespace PA_PROYECTO_ESPIGADORADA
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
