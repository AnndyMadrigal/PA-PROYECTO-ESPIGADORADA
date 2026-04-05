$(document).ready(function () {
    // Método personalizado para verificar extensiones de archivo
    if ($.validator) {
        $.validator.addMethod("imageFileExtension", function (value, element) {
            if (!value) return true; // Permitimos vacío si no hay valor (el required lo atrapa si es obligatorio)
            var ext = value.split('.').pop().toLowerCase();
            return $.inArray(ext, ['jpg','jpeg','png']) !== -1;
        }, "Por favor, seleccione una imagen válida (jpg, jpeg, png).");
    }

    var rulesConfig = {
        product_name: {
            required: true,
            maxlength: 100
        },
        sku: {
            required: true,
            maxlength: 50
        },
        unit_price: {
            required: true,
            number: true,
            min: 0.01
        },
        description: {
            maxlength: 255
        },
        category_id: {
            required: true
        },
        unit_of_measure: {
            required: true,
            maxlength: 50
        },
        min_stock: {
            required: true,
            number: true,
            min: 0
        },
        tax_id: {
            required: true
        },
        is_active: {
            required: true
        }
    };

    var messagesConfig = {
        product_name: {
            required: "El nombre del producto es obligatorio.",
            maxlength: "No puede exceder los 100 caracteres."
        },
        sku: {
            required: "El SKU es obligatorio.",
            maxlength: "No puede exceder los 50 caracteres."
        },
        unit_price: {
            required: "El precio unitario es obligatorio.",
            number: "Ingrese un valor numérico.",
            min: "El precio debe ser mayor a 0."
        },
        description: {
            maxlength: "La descripción no puede exceder los 255 caracteres."
        },
        category_id: {
            required: "Debe seleccionar una categoría."
        },
        unit_of_measure: {
            required: "La unidad de medida es obligatoria.",
            maxlength: "No puede exceder los 50 caracteres."
        },
        min_stock: {
            required: "El stock mínimo es obligatorio.",
            number: "Ingrese un valor numérico válido.",
            min: "El stock no puede ser negativo."
        },
        tax_id: {
            required: "Debe seleccionar un impuesto."
        },
        is_active: {
            required: "Seleccione un estado."
        }
    };

    // Formulario de Crear
    if ($("#createProductForm").length) {
        var createRules = $.extend(true, {}, rulesConfig);
        createRules.imageFile = {
            required: true,
            imageFileExtension: true
        };

        var createMessages = $.extend(true, {}, messagesConfig);
        createMessages.imageFile = {
            required: "Debe seleccionar una imagen."
        };

        $("#createProductForm").validate({
            ignore: [],
            rules: createRules,
            messages: createMessages,
            errorElement: "span",
            errorPlacement: function (error, element) {
                error.addClass("text-danger");
                if (element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).addClass("is-valid").removeClass("is-invalid");
            }
        });
    }

    // Formulario de Editar
    if ($("#editProductForm").length) {
        var editRules = $.extend(true, {}, rulesConfig);
        editRules.imageFile = {
            required: false,
            imageFileExtension: true
        };

        var editMessages = $.extend(true, {}, messagesConfig);
        editMessages.imageFile = {
            imageFileExtension: "Por favor, seleccione una imagen válida (jpg, jpeg, png, gif)."
        };

        $("#editProductForm").validate({
            ignore: [],
            rules: editRules,
            messages: editMessages,
            errorElement: "span",
            errorPlacement: function (error, element) {
                error.addClass("text-danger");
                if (element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).addClass("is-valid").removeClass("is-invalid");
            }
        });
    }
});
