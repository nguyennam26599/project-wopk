$(document).on('turbolinks:load', function() {
    $(".btn-follow").click(function(){
        const btnFollow = $(this);
        const tagID = btnFollow.data('tag-id');
        const follow = "Follow";
        const unFollow = "Unfollow";
        const followUrl = $('.path_current_tag').data('tag-follow-path');
        const data = {
            tagID: tagID
        }
        $.ajax({
            type: "POST",
            url: followUrl,
            data: data,
            dataType: "json",
            success: function(data){
                if(data.status){
                    if (btnFollow.text().trim() === follow) {
                        btnFollow.text(unFollow).removeClass("btn-success").addClass("btn-danger");
                    } else {
                        btnFollow.text(follow).removeClass("btn-danger").addClass("btn-success");
                    }
                    setFollow(data.data.followerSize, $(`#follow-size-${tagID}`));
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
  
