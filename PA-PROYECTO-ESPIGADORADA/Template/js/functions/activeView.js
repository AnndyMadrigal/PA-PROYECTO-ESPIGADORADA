
$(document).ready(function () {
    //Obtener la ruta actual
    var path = window.location.pathname.toLowerCase();

    //Limpiar 'active' de todos los enlaces
    $('.navbar-nav .nav-link').removeClass('active');

    //Si la ruta es solo la raíz o Home/Index explícito, marcamos el inicio
    if (path === "/" || path === "/home/index" || path === "/home") {
        //En tu diseño, "Inicio" siempre es el primer enlace
        $('.navbar-nav .nav-link').first().addClass('active');
    } else {
        //Buscar el enlace que coincida con la ruta y agregarle 'active'
        $('.navbar-nav .nav-link').each(function () {
            var href = $(this).attr('href');
            if (href && href.toLowerCase() === path) {
                $(this).addClass('active');
            }
        });
    }
});
