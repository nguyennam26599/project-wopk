# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag
  before_action :load_leaderboard
  def search
    @tags = Tag.search_name_status_public(params[:term]).limit(5)
    render json: @tags.pluck(:name)
  end

  def index
    @tags = Tag.tag_list_order_follower
    @pagy, @tag = pagy(@tags, items: NUMBER_PAGE_15)
  end

  def show
    if @tag.blank?
      redirect_to tags_path
    else
      @pagy, @post = pagy(@tag.posts.status_public.sort_new_post, items: NUMBER_PAGE_15)
      @post_trend = @tag.posts.top_post_public_this_month.limit(NUMBER_PAGE_10)
    end
  end

  def load_leaderboard
    @users_trend = User.leaderboard_user_posts
    @tags_trend = Tag.leaderboard_tags_posts
  end

  def follow_tag
    tag = Tag.find_by(id: params[:tag_id])
    if FollowPolymorphic.find_by(follower: current_user, following: tag).blank?
      FollowPolymorphic.create(follower: current_user, following: tag)
    else
      FollowPolymorphic.find_by(follower: current_user, following: tag).destroy
    end

    data = {
      follow_value: tag.followers.size
    }
    render json: { status: true, data: data }
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end
end
