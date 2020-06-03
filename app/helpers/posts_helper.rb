# frozen_string_literal: true

module PostsHelper
  def avatar_for(user, avt_class)
    if @avatar.blank?
      image_tag('/default-user-avatar.png', class: avt_class.to_s, alt: user.name)
    else
      image_tag(user.avatar, class: avt_class.to_s, alt: user.name)
    end
  end
end
