# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :set_locale
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

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale.to_sym : nil
  end
end
