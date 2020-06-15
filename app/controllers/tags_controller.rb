# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag
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

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end
end
