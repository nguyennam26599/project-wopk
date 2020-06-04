# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @pagy_daily, @posts_daily = pagy(Post.all.order(created_at: :desc).order(view_count: :desc), page_param: :page)
  end

  def posts_weekly
    @pagy_weekly, @posts_weekly = pagy(Post.all.this_week.order(view_count: :desc), page_param: :page)
  end

  def posts_monthly
    @pagy_monthly, @posts_monthly = pagy(Post.all.this_month.order(view_count: :desc), page_param: :page)
  end

  def tagfeed
    @pagy, @posts = pagy(Post.all, page: params[:page])
  end
end
