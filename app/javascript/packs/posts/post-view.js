$(document).on("turbolinks:load", function () {
    let first_time = true

    $(window).on("scroll", function () {
        const scrollHeight = $(document).height(); 
        const scrollPosition = $(window).height() + $(window).scrollTop();

        if ((scrollHeight - scrollPosition) === 0) {
            // scroll to bottom of the page
            const view_path = $('#path_current').data('view-path');
            if (first_time) {
                $.ajax({
                    type: "POST",
                    url: view_path,
                    dataType: "json",
                    success: function (data) {
                        if (data.status) {
                            $('#post_view').html(data.post_view);
                            first_time = false;
                        } else {
                            console.log("error", data.status)
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }
        }
    });
});
