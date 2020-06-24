$(document).on("turbolinks:load", function() {
  $(".btn_share_facebook").click(function() {
    let url = $('#url_post').data('url-post');
    window.open('http://facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url), '', 'width=650,height=420,personalbar=0,toolbar=0,scrollbars=0');
  });
  $(".btn_share_twitter").click(function() {
    let url = $('#url_post').data('url-post');
    let text = $('#title_post').data('title-post');
    window.open('http://twitter.com/share?url=' + encodeURIComponent(url) + '&text=' + encodeURIComponent(text), '', 'width=550,height=450,personalbar=0,toolbar=0,scrollbars=0');
  });
});