# frozen_string_literal: true

module Admins
  class UsersController < BaseController
    before_action :set_user, only: %i[show update destroy]
    add_breadcrumb 'Home', :admins_root_path
    add_breadcrumb 'Users', :admins_users_path

    def index
      @users_list = SearchService.new(params).perform(User)
      @pagy, @users = pagy(@users_list.order(created_at: :desc), page: params[:page], items: NUMBER_PAGE_20)
    end

    def show
      add_breadcrumb @user.name, admins_user_path
      @pagy, @posts = pagy(@user.posts, page: params[:page], items: NUMBER_PAGE_10)
    end

    def update
      @user.update status: params[:user_status]
      redirect_to admins_users_path
    end

    def destroy
      @user.destroy
      redirect_to admins_users_path
    end
  
    private

    def set_user
      @user = User.find_by(id: params[:id])
      return redirect_to admins_users_path if @user.blank?
    end
  end
end
