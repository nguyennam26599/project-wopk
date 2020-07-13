# frozen_string_literal: true

module Admins
  class PagesController < BaseController
    add_breadcrumb 'Home', :admins_root_path

    def index; end
  end
end
