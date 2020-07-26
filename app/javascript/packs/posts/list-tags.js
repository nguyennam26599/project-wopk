$(document).on("turbolinks:load", function () {
  $("#tag-data").tagsinput({ 
    maxTags: 5, 
    trimValue: true
  });

  $("#tag-data").on('beforeItemAdd', function(event) {
      if (event.item !== event.item.toLowerCase()) {
          event.cancel = true;
          $(this).tagsinput('add', event.item.toLowerCase());
      }
  });

  $(".bootstrap-tagsinput input").autocomplete({
    source: $("#tag-data").data("autocomplete-source")
  });

  $(".ui-autocomplete").appendTo(".menu-list");

  $(".bootstrap-tagsinput input, .form-control")
    .focusin(function () {
      $(this).parents().filter(".bootstrap-tagsinput").addClass("border-focus");
    })
    .focusout(function () {
      $(this)
        .parents()
        .filter(".bootstrap-tagsinput")
        .removeClass("border-focus");
    });
});
