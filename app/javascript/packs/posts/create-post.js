$(document).on("turbolinks:load", function () {
  $(".post-publish").click(function () {
    $(".text-scope-status").html(
      `<i class="fas fa-globe-americas"></i> Everyone can see your post`
    );
    $(".btn-scope").html("Publish");
  });

  $(".post-draft").click(function () {
    $(".text-scope-status").html(`
            <i class="fas fa-user-lock"></i> 
            Only you can see this post. 
            Your draft is <br>already saved automatically as you type.
        `);
    $(".btn-scope").html("Save draft");
  });

  $(".btn-dropdown-status").click(function () {
    let titleValue = $("#title").val();
    let textContent = $("#post_content").text();
    let avatarPost = $(".avatar-post-value").val();
    if (titleValue.trim() != "" && textContent.trim() != "" && avatarPost != "") {
      $(".dropdown-menu-btn").toggle();
    } else {
      $(".dropdown-menu-text").toggle();
    }
  });

  $("input[type = 'text'], .bootstrap-tagsinput, .form-area").click(
    function () {
      $(".dropdown-menu-btn, .dropdown-menu-text").hide();
    }
  );
});
