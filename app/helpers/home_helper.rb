# frozen_string_literal: true

module HomeHelper
  def fa_icon(i_class, text)
    "<i class='#{i_class}'></i> #{text}".html_safe
  end

  def current_class?(test_path)
    return 'p-home_menuItem-active' if request.path == test_path
  end

  def login_banner
    render 'home/banner' unless user_signed_in?
  end
end
