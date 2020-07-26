# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  NUMBER_PAGE_5 = 5
  NUMBER_PAGE_15 = 15
  NUMBER_PAGE_20 = 20
  NUMBER_PAGE_10 = 10

  DAILY_POST = 'daily'
  WEEKLY_POST = 'weekly'
  MONTHLY_POST = 'monthly'

  def class_active(controller)
    'active bg-dark-4' if params[:controller] == controller
  end

  def show_header
    exception_path = [login_path, signup_path, confirm_path, new_user_session_path,
                      new_admin_session_path, new_user_password_path, edit_user_password_path]
    render partial: 'home/header' unless exception_path.include? request.path
  end

  def show_footer
    exception_path = [login_path, signup_path, confirm_path, new_user_session_path,
                      new_admin_session_path, new_user_password_path, reset_password_path, edit_user_password_path]
    render partial: 'home/footer' unless exception_path.include? request.path
    render partial: 'home/footer' unless params[:controller] == 'posts' && params[:action] != 'show'
  end

  def active_post_home(scope)
    params[:scope] ||= Post::DAILY_POST
    'navbar-root-active' if params[:scope] == scope
  end

  def date_format(object)
    object.strftime('%d/%m/%Y - %H:%M')
  end

  def full_title(page_title)
    page_title
  end
end
