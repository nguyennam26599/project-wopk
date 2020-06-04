# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
    @pagy, @posts = pagy(@user.posts.all, page: params[:page])
  end
end
