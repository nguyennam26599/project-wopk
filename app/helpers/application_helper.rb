# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  NUMBER_PAGE = 15

  def active(controller)
    'active' if params[:controller] == controller
  end

<<<<<<< HEAD
  def show_header
    exception_path = [login_path, signup_path, confirm_path, new_user_session_path, new_admin_session_path]
    render partial: 'home/header' unless exception_path.include? request.path
  end

  def show_footer
    exception_path = [login_path, signup_path, confirm_path, new_user_session_path, new_admin_session_path]
    render partial: 'home/footer' unless exception_path.include? request.path
=======
  def active_post(scope)
    params[:scope] ||= 'pending'
    'active' if params[:scope] == scope
>>>>>>> feat: show list post
  end
end
