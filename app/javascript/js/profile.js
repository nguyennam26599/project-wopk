$(document).on('turbolinks:load', function() {
  $('.select_location').on('change', function(){
   window.location = $(this).val();
  });

  $(".bootstrap-tagsinput input").autocomplete({
    source: $("#tag-data").data("autocomplete-source"),
  });
});
