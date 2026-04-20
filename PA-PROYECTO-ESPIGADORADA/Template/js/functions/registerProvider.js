$(document).ready(function () {
    // Configuración de validación con jQuery Validate
    $("#FormRegisterProvider").validate({
        rules: {
            Name: {
                required: true,
                minlength: 2
            },
            Email: {
                required: true,
                email: true
            },
            Phone: {
                required: true,
                digits: true,
                minlength: 8,
                maxlength: 8
            }
        },
        messages: {
            Name: {
                required: "Por favor, ingrese el nombre del proveedor",
                minlength: "El nombre debe tener al menos 2 caracteres"
            },
            Email: {
                required: "Por favor, ingrese un correo electrónico",
                email: "Por favor, ingrese un correo electrónico válido"
            },
            Phone: {
                required: "Por favor, ingrese un número de contacto",
                digits: "Por favor, ingrese solo números",
                minlength: "El número debe tener al menos 8 dígitos",
                maxlength: "El número no debe ser mayor a 8 dígitos"
            }
        },
        errorElement: "span",
        errorClass: "text-danger small mt-1 d-block",
        highlight: function (element) {
            $(element).addClass("is-invalid").removeClass("is-valid");
        },
        unhighlight: function (element) {
            $(element).addClass("is-valid").removeClass("is-invalid");
        }
    });

    // Filtro adicional para el campo Phone: solo permitir escribir números en tiempo real y limitar a 8 dígitos
    $("#Phone").on("input", function () {
        this.value = this.value.replace(/[^0-9]/g, '').slice(0, 8);
    });
});
