# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :load_leaderboard

  def index
    @pagy, @posts = pagy(Post.find_post_home_index(params[:scope]))
  end

  def home
    return home_path if current_user.blank?

    @pagy, @posts = pagy(Post.post_followings(current_user))
  end

  def clippost
    @pagy, @posts = pagy(current_user.post_followings.status_public, page: params[:page]) unless current_user.blank?
  end

  def load_leaderboard
    @users_trend = User.leaderboard_user_posts
    @tags_trend = Tag.leaderboard_tags_posts
    @tags_follow = current_user.tag_followings if current_user.present?
  end

  def search
    return redirect_to(root_path, alert: 'Empty field!') if params[:search].blank?

    @parameter = params[:search].downcase
    @pagy, @posts = pagy(Post.status_public.where('lower(title) LIKE :search', search: "%#{@parameter}%"))
  end
end
