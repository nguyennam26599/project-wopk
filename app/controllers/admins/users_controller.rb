# frozen_string_literal: true

module Admins
  class UsersController < BaseController
    def index
      @pagy, @users = pagy(User.all, page: params[:page], items: NUMBER_LIST_USER_20)
    end
  end
end
