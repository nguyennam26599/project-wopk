const { data } = require("jquery");

$(document).on("turbolinks:load", function () {
    let first_time = true
    const time = $("#read_time").data("read-time") * 60000;
            // scroll to bottom of the page
    const view_path = $('#path_current').data('view-path');
    setTimeout(() => {
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
    }, time);
});
