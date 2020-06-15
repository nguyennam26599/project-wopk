# frozen_string_literal: true

module Admins
  class PostsController < BaseController
    before_action :set_post, only: %i[update show]

    def index
      scope_post = params[:scope] || Post::PENDING_STATUS
      @pagy, @posts = pagy(Post.where(status: scope_post))
    end

    def show
      @user = @post.user
    end

    def update
      @post.update status: params[:approve_status]
      redirect_to admins_posts_path
    end

    private

    def set_post
      @post = Post.find_by(id: params[:id])
      return redirect_to admins_posts_path if @post.blank?
    end
  end
end
