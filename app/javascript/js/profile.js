$(document).on('turbolinks:load', function() {
  $('.select_location').on('change', function(){
   window.location = $(this).val();
  });
});
