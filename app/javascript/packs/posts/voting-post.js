$(document).on("turbolinks:load", function () {
    const user_create_post = $('#user_create_post').data('user-create-post');
    // debugger
    if(user_create_post){
        $(".btn-voted").click(function () {
            if ($(this).hasClass("voted") == true) {
                $(this).removeClass("voted");
            } else {
                resetClass();
                $(this).addClass("voted");
            }
        });

        function resetClass() {
            $(".btn-voted").removeClass("voted");
        }
    }
});