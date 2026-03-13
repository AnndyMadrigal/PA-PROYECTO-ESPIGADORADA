$(function () {
  $("#FormRegister").validate({
    rules: {
      Identification: {
        required: true
      },
      Name: {
        required: true
      },
      Email: {
        required: true,
        email: true
      },
      Password: {
        required: true
      }
    },
    messages: {
        Identification: {
        required: "Campo requerido"
      },
        Name: {
        required: "Campo requerido"
      },
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

function CheckName() {

  document.getElementById("Name").value = "";

    let identification = document.getElementById("Identification").value;

  if (identification.length >= 9) {
    $.ajax({
      url: `https://apis.gometa.org/cedulas/${identification}`,
      type: 'GET',
      dataType: 'json',
      success: function (response) {

        if (response?.results?.[0]?.fullname)
          document.getElementById("Name").value = response.results[0].fullname;

      }
    });
  }

}