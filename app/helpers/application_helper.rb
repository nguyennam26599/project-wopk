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
    'active' if params[:controller] == controller
  end

  def show_header
    exception_path = [login_path, signup_path, confirm_path, new_user_session_path, new_admin_session_path]
    render partial: 'home/header' unless exception_path.include? request.path
  end

  def show_footer
    exception_path = [login_path, signup_path, confirm_path, new_user_session_path, new_admin_session_path]
    render partial: 'home/footer' unless exception_path.include? request.path
  end

  def active_post_home(scope)
    params[:scope] ||= Post::DAILY_POST
    'navbar-root-active' if params[:scope] == scope
  end

  def sub_label_page_index(scope_post)
    if scope_post == WEEKLY_POST
      'Remarkable items.Refleshed every Monday.'
    elsif scope_post == MONTHLY_POST
      'Remarkable items.Refleshed on 1st every month.'
    else
      'Remarkable items. Refleshed at every 5 a.m.and 5 p.m.'
    end
  end

  def date_format(object)
    object.strftime('%d/%m/%Y - %H:%M')
  end
end
