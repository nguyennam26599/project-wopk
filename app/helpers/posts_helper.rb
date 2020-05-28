# frozen_string_literal: true

module PostsHelper
  def avatar_for(user, avt_class)
    @avatar = user.avatar
    @avatar_user = if @avatar.blank?
                     image_tag('/default-avatar.jpg', class: "avatar avatar--#{avt_class}", alt: user.name)
                   else
                     image_tag(@post.user.avatar, class: "avatar avatar--#{avt_class}", alt: user.name)
                   end
    @avatar_user
  end
end
