# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to current_user
    else
      render action: 'edit'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @pagy, @posts = pagy(@user.posts.where(status: 'pending'), page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :gender, :first_name, :last_name, :url_link, :organization, :address, :birthday,
      :facebook_link, :github_link, :linkedln_link, :description, :avatar, :email_public
    )
  end
end
