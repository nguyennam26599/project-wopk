$(document).on('turbolinks:load', function() {
  $('.textbox-search').focusin(function() {
    $('.btn_search_laptop').addClass("border-focus")
  }).focusout(function() {
    $('.btn_search_laptop').removeClass("border-focus")
  });

  $("#post-data").keydown(function(){
    $("#post-data").autocomplete({
      source: $("#post-data").data("autocomplete-source")
    });
  
    $(".ui-autocomplete").appendTo(".menu-list-post");
  });
});
