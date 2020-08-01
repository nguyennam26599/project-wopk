const { ajax } = require("jquery");

$(document).on('turbolinks:load', function() {
  $('.select_location').on('change', function(){
   window.location = $(this).val();
  });

  $(".bootstrap-tagsinput input").autocomplete({
    source: $("#tag-data").data("autocomplete-source"),
  });
  const mode_path = $("#togBtn").data("mode-path");
  let type_mode = $("#togBtn").data("type");
  const data = {
    mode: type_mode
  }
  
  let boolean_mode = $("#togBtn").data("checked");
  $("#togBtn").prop("checked", boolean_mode);

  if (boolean_mode == false) {
    $(".bg-dark-6, .bg-gray-light-4, .bg-gray-light-3, bg-blue-dark").toggleClass("light-mode-background");
    $(".bg-dark-4").toggleClass("light-mode-box");
    $(".text-muted-light").toggleClass("text-mode-dark");
  }

  $("#togBtn").change(function() {
    $(".p-home_menuItem").toggleClass("active-mode-box");
    $(".bg-dark-6, .bg-gray-light-4, .bg-gray-light-3, bg-blue-dark").toggleClass("light-mode-background");
    $(".bg-dark-4").toggleClass("light-mode-box");
    $(".text-muted-light").toggleClass("text-mode-dark");
    $(".p-home_menuItem").toggleClass("active-mode-box");
    $.ajax({
      type: "POST",
      url: mode_path,
      dataType: "json",
      data: data
    });
    setTimeout(() => {
     window.location.reload(); 
    }, 10);
  });
});