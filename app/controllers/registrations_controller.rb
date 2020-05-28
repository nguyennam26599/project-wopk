# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(_resource)
    confirm_path
  end
end
