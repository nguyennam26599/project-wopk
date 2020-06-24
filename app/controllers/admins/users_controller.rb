# frozen_string_literal: true

module Admins
  class UsersController < BaseController
    before_action :set_user, only: %i[show update]

    def index
      @pagy, @users = pagy(search_user_admin, page: params[:page], items: NUMBER_PAGE_20)
    end

    def show
      @pagy, @posts = pagy(@user.posts, page: params[:page], items: NUMBER_PAGE_10)
    end

    def update
      @user.update status: params[:user_status]
      redirect_to admins_users_path
    end

    private

    def set_user
      @user = User.find_by(id: params[:id])
      return redirect_to admins_users_path if @user.blank?
    end

    def search_user_admin
      params[:search].blank? && params[:status].blank? ? User.all : User.search(params[:search], params[:status])
    end
  end
end
