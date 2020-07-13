$(document).on("turbolinks:load", function() {
  $(".btn_share_facebook").click(function() {
    let url = $('#url_post').data('url-post');
    share_facebook(url);
  });
  $(".btn_share_twitter").click(function() {
    let url = $('#url_post').data('url-post');
    let text = $('#title_post').data('title-post');
    share_twitter(url, text);
  });
  function share_facebook(url) {
    window.open('http://facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url), '', 'width=650,height=420,personalbar=0,toolbar=0,scrollbars=0');
  }
  function share_twitter(url,text) {

    window.open('http://twitter.com/share?url=' + encodeURIComponent(url) + '&text=' + encodeURIComponent(text), '', 'width=550,height=450,personalbar=0,toolbar=0,scrollbars=0');
  }
});
