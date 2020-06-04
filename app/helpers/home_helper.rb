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

  def current_class?(test_path)
    return 'p-home_menuItem-active' if request.path == test_path
  end

  def check_class_index(test_path)
    'p-home_menuItem-active' if [root_path, posts_weekly_path, posts_monthly_path].include? test_path
  end
  def login_banner
    unless user_signed_in?
      render "home/banner"
    end
  end
end
