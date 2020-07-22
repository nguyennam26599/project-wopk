# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :load_leaderboard

  def index
    @pagy, @posts = pagy(Post.find_post_home_index(params[:scope]))
  end

  def tagfeed
    posts_user = []
    posts_tag = []
    current_user.user_followings.each do |post_user|
      posts_user += post_user.posts
    end
    current_user.tag_followings.each do |post_tag|
      posts_tag += post_tag.posts
    end
    posts_followings = posts_user + posts_tag
    @pagy, @posts = pagy(posts_followings, page: params[:page])
  end

  def clippost
    @pagy, @posts = pagy(current_user.post_followings, page: params[:page]) unless current_user.blank?
  end

  def load_leaderboard
    @users_trend = User.leaderboard_user_posts
    @tags_trend = Tag.leaderboard_tags_posts
  end
end
