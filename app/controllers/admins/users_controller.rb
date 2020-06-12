# frozen_string_literal: true

module Admins
  class UsersController < BaseController
    before_action :set_user, only: %i[show]

    def index
      @pagy, @users = pagy(User.all, page: params[:page], items: NUMBER_PAGE_20)
    end

    def show
      @pagy, @posts = pagy(@user.posts, page: params[:page], items: NUMBER_PAGE_10)
    end

    private

    def set_user
      @user = User.find_by(id: params[:id])
    end
  end
end
