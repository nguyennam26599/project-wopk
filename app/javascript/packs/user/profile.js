$(document).on('turbolinks:load', function() {
  $('a.page-link').click(function() {
    $('html, body').animate({
      scrollTop: $(".jump").offset().top
    }, 1000)
  });
});