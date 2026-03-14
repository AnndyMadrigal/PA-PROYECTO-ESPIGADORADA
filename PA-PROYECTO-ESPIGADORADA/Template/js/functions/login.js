$(function () {
  $("#FormLogin").validate({
    rules: {
      Email: {
        required: true,
        email: true
      },
      Password: {
        required: true
      }
    },
    messages: {
      Email: {
        required: "Campo requerido",
        email: "Formato incorrecto"
      },
      Password: {
        required: "Campo requerido"
      }
    },
    errorElement: "span",
    errorClass: "text-danger",
    highlight: function (element) {
      $(element).addClass("is-invalid");
    },
    unhighlight: function (element) {
      $(element).removeClass("is-invalid");
    }
  });
});