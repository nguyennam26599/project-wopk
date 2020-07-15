# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to profile_path
    else
      render action: 'edit'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user == current_user
      @pagy, @posts = pagy(Post.find_post_current_user(params[:status]))
    else
      @pagy, @posts = pagy(@user.posts.status_public, page: params[:page])
    end
  end

  def show_post_public
    @pagy, @posts = pagy(current_user.posts.status_public, page: params[:page])
  end

  def show_post_draft
    @pagy, @posts = pagy(current_user.posts.status_draft, page: params[:page])
  end

  def show_post_pending
    @pagy, @posts = pagy(current_user.posts.status_pending, page: params[:page])
  end

  def show_post_close
    @pagy, @posts = pagy(current_user.posts.status_close, page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :gender, :first_name, :last_name, :url_link, :organization, :address, :birthday,
      :facebook_link, :github_link, :linkedln_link, :description, :avatar, :email_public
    )
  end
end
