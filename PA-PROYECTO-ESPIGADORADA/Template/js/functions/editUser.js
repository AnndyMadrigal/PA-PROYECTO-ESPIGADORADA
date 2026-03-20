$(function () {
    //ajustamos las reglas de validación para edición porque la contraseña es opcional
    $("#FormEdit").validate({
        rules: {
            Identification: "required",
            Name: "required",
            Email: { required: true, email: true }
        },
        messages: {
            Identification: "Campo requerido",
            Name: "Campo requerido",
            Email: { required: "Campo requerido", email: "Formato incorrecto" }
        },
        errorElement: "span",
        errorClass: "text-danger",
        highlight: function (element) { $(element).addClass("is-invalid"); },
        unhighlight: function (element) { $(element).removeClass("is-invalid"); }
    });
});