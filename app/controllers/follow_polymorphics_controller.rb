# frozen_string_literal: true

class FollowPolymorphicsController < ApplicationController
  def create
    FollowPolymorphic.create(follower: current_user, following_id: params[:id], following_type: params[:type])
    @user = User.find_by(id: params[:id])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find_by(id: FollowPolymorphic.find_by(id: params[:id]).following_id)
    FollowPolymorphic.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def clip
    @post = Post.find_by(id: params[:id])
    if FollowPolymorphic.user_follow_post(current_user, @post).present?
      FollowPolymorphic.user_follow_post(current_user, @post).destroy
      notice_post_follow = FollowPolymorphic::NOTICE_DESTROY
    else
      FollowPolymorphic.create_follow_post(current_user, @post)
      notice_post_follow = FollowPolymorphic::NOTICE_CREATE
    end
    respond_to do |format|
      format.html { redirect_to @post }
      format.js { flash.now[:notice] = notice_post_follow }
    end
  end
end
