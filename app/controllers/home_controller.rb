# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :load_leaderboard

  def index
    @pagy, @posts = pagy(Post.find_post_home_index(:scope))
  end

  def tagfeed
    @pagy, @posts = pagy(Post.all, page: params[:page])
  end

  def clippost; end

  def load_leaderboard
    @users_trend = User.leaderboard_user_posts
    @tags_trend = Tag.leaderboard_tags_posts
  end
end
