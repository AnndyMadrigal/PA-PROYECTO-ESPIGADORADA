$(function () {
  $("#FormChangePassword").validate({
    rules: {
      NewPassword: {
        required: true
      },
      ConfirmPassword: {
        required: true,
        equalTo: "#NewPassword"
      }
    },
    messages: {
      NewPassword: {
        required: "Campo requerido"
      },
      ConfirmPassword: {
        required: "Campo requerido",
        equalTo: "Las contraseñas no coinciden"
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