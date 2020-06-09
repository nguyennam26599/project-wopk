# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    include Pagy::Backend
    before_action :authenticate_admin!
  end
end
