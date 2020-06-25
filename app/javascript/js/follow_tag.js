$(document).on('turbolinks:load', function() {
    $(".btn-follow").click(function(){
        const btnFollow = $(this);
        const tag_id = btnFollow.data('tag-id');
        const data = {
            tag_id: tag_id
        }
        $.ajax({
            type: "POST",
            url: "/tags/follow_tag",
            data: data,
            dataType: "json",
            success: function(data){
                if(data.status){
                    if (btnFollow.text().trim() === "Follow") {
                        btnFollow.text("Unfollow").removeClass("btn-success").addClass("btn-danger");
                    } else {
                        btnFollow.text("Follow").removeClass("btn-danger").addClass("btn-success");
                    }
                    setFollow(data.data.follow_value, $(`#follow-size-${tag_id}`));
                }else{
                    console.log("error", data.status)
                }
            },
            error: function(error){
                console.log(error);
            }
          });
    })
    function setFollow(followNumber, followSize){
        followSize.text(followNumber);
    }
  });
  
