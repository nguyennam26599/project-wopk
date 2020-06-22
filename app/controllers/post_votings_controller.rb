# frozen_string_literal: true

class PostVotingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[vote]

  def vote
    return if @post.user == current_user

    PostVoting.voting(current_user.id, @post.id, PostVoting.check_vote?(params[:vote_status]))
    @post.reload
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])

    return redirect_to root_path if @post.blank?
  end
end
