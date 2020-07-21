$(document).on("turbolinks:load", function () {
    let page = 2;
    $('#load-more').on("click", function(){

        const comments_path = $('#path_comments').data('comments-path');
        const comments_size = $('#size_comments').data('comments-size');
        const data = {page: page};
        
        $.ajax({
            type: "GET",
            data: data,
            url: comments_path,
            dataType: "json",
            success: function (data) {
                console.log(data.comment_data);
                
                if (data.status) {
                    console.log(data.comment_data);
                    data.list_comment.forEach(obj => comment_append(obj,data.comment_data));
                    page ++;
                } else {
                    console.log("error", data.status);
                }

                if(( page - 1 ) * data.number_comment >= comments_size){
                    $("#load-more").fadeOut();
                }
            },
            error: function (error) {
            }
        });

        function comment_append(obj,data){
            $('#list-comments').append(`<div class="card mb-1">
                                            <div class="w-100 d-flex">
                                                <div class="w-avatar p-2">
                                                    <a href="${obj.user.url}"><img src= ${obj.user.avatar_url} class='img-user-comment rounded-circle' ></a>
                                                </div>
                                                <div class="w-content p-2">
                                                    <div class="font-weight-bold w-user-name">
                                                        <a href="${obj.user.url}" class="font-weight-bold">${obj.user.name}</a>
                                                    </div>
                                                    <div class="w-comnet-time">
                                                        <i class="far fa-clock"></i>
                                                        ${obj.time_ago} ago.
                                                    </div>
                                                    <div id="content-comment" class="p-1 bg-light w-100 mt-2 float-left">${obj.content}</div>
                                                </div>
                                            </div>
                                        </div>`);
        };
    });

    $('textarea').each(function () {
        this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
      }).on('input', function () {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
      });

    $("#comment-content-new").keyup("click", function(event){
        if (!$.trim($("#comment-content-new").val())) {
            event.preventDefault();
            $("#create-comment").prop('disabled', true);
        }else{
            $("#create-comment").prop('disabled', false);
        }
    });

    $('.edit-comment').click(function() {
        $('.post-comment-edit').hide();
    });
});
