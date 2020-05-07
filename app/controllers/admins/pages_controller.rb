# frozen_string_literal: true

module Admins
  class PagesController < ApplicationController
    before_action :admin_user?
    def index; end

    def form; end

    def table; end

    def admin_user?
      redirect_to new_admin_session_path unless current_admin.try(:admin?)
    end
  end
end
