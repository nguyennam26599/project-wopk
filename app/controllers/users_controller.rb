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
    @pagy, @posts = pagy(@user.posts.status_public, page: params[:page])
  end

  def show_post_public
    @pagy, @posts = pagy(current_user.posts.status_public)
  end

  def show_post_draft
    @pagy, @posts = pagy(current_user.posts.status_draft)
  end

  def show_post_pending
    @pagy, @posts = pagy(current_user.posts.status_pending)
  end

  def show_post_close
    @pagy, @posts = pagy(current_user.posts.status_close)
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :gender, :first_name, :last_name, :url_link, :organization, :address, :birthday,
      :facebook_link, :github_link, :linkedln_link, :description, :avatar, :email_public
    )
  end
end
