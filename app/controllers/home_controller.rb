# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @pagy, @posts = pagy(Post.find_post_home_index(:scope))
  end

  def tagfeed
    @pagy, @posts = pagy(Post.all, page: params[:page])
  end
end
