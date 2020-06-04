# frozen_string_literal: true

module HomeHelper
  def avatar_for(user, avt_class)
    @avatar = user.avatar
    @avatar_user = if @avatar.blank?
                     image_tag('/default-user-avatar.png', class: avt_class.to_s, alt: user.name)
                   else
                     image_tag(user.avatar, class: avt_class.to_s, alt: user.name)
                   end
  end

  def fa_icon(i_class, text)
    "<i class='#{i_class}'></i> #{text}".html_safe
  end
end
