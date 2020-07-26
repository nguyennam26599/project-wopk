$(document).on("turbolinks:load", function () {
  var updateButton = document.getElementById("updateDetails");
  var favDialog = document.getElementById("favDialog");
  var deleteButton = document.getElementById("cancel");

  // “Update details” button opens the <dialog> modally
  updateButton.addEventListener("click", function () {
    favDialog.showModal();
    favDialog.classList.add('dialog-scale');
  });
  deleteButton.addEventListener("click", function () {
    favDialog.close();
    favDialog.classList.remove('dialog-scale');
  });
});
