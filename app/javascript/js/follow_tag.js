$(document).on('turbolinks:load', function() {
    $(".btn-follow").click(function(){
        const btnFollow = $(this);
        const tag_id = btnFollow.data('tag-id');
        const follow = "Follow";
        const unfollow = "Unfollow";
        const follow_url = $('.path_current_tag').data('tag-follow-path');
        const data = {
            tag_id: tag_id
        }
        $.ajax({
            type: "POST",
            url: follow_url,
            data: data,
            dataType: "json",
            success: function(data){
                if(data.status){
                    if (btnFollow.text().trim() === follow) {
                        btnFollow.text(unfollow).removeClass("btn-success").addClass("btn-danger");
                    } else {
                        btnFollow.text(follow).removeClass("btn-danger").addClass("btn-success");
                    }
                    setFollow(data.data.follower_size, $(`#follow-size-${tag_id}`));
                }else{
                }
            },
            error: function(error){
            }
          });
    })
    function setFollow(followNumber, followSize){
        followSize.text(followNumber);
    }
  });
  
