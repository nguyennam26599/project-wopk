# frozen_string_literal: true

module HomeHelper
  CUP_GOLD = 1
  CUP_SILVER = 2
  CUP_BRONZE = 3

  def fa_icon(i_class, text = '')
    "<i class='#{i_class}'></i> #{text}".html_safe
  end

  def current_class?(test_path)
    return 'bg-blue-dark rounded' if request.path == test_path
  end

  def login_banner
    render 'home/banner' unless user_signed_in?
  end

  def print_number_leaderboard(number)
    case number
    when CUP_GOLD
      '<span class="fa fa-trophy fa-fw color-gold align-self-center mx-2"></span>'
    when CUP_SILVER
      '<span class="fa fa-trophy fa-fw color-silver align-self-center mx-2"></span>'
    when CUP_BRONZE
      '<span class="fa fa-trophy fa-fw color-bronze align-self-center mx-2"></span>'
    else
      "<span class='font-weight-bold align-self-center text-center mx-2 text-muted'>#{number}</span>"
    end
  end

  def container_header
    if (params[:controller] == 'posts') && params[:action] == 'edit' || params[:action] == 'new'
      'container-fluid'
    else
      'container-fuild'
    end
  end

  def active_color?(test_path)
    request.path == test_path ? 'bg-blue-dark-4' : 'bg-gray-light-4'
  end
end
