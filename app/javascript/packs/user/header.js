$(document).on('turbolinks:load', function() {
  $('.textbox-search').focusin(function() {
    $('.btn_search_laptop').addClass("border-focus")
  }).focusout(function() {
    $('.btn_search_laptop').removeClass("border-focus")
  });
});
