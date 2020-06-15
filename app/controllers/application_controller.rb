# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit({ roles: [] }, :email, :password, :password_confirmation, :name)
    end
    update_attrs = %i[name password password_confirmation current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def after_sign_in_path_for(resource)
    if resource.class == User
      user_status_update(resource)
      root_path
    elsif resource.class == Admin
      admins_root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    elsif resource == :user
      new_user_session_path
    else
      root_path
    end
  end

  # update user status
  def user_status_update(resource)
    resource.update status: 'actived' if resource.confirmed? && resource.status == 'deactived'
  end
end
