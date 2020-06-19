$(document).on("turbolinks:load", function () {
  $(".clip-button").click(function(){
    $("a.clip-button").toggleClass('bg-info text-white');
  });
});
