# frozen_string_literal: true

module Admins
  class PostsController < BaseController
    before_action :set_post, only: %i[show]
    before_action :set_post_approve, only: %i[approve decline]

    def index
      scope_post = params[:scope] || Post::PENDING_STATUS
      @pagy, @posts = pagy(Post.where(status: scope_post))
    end

    def show
      @user = @post.user
    end

    def approve
      @post.update status: Post::PUBLIC_STATUS
      redirect_to admins_posts_path
    end

    def decline
      @post.update status: Post::CLOSE_STATUS
      redirect_to admins_posts_path
    end

    private

    def set_post
      @post = Post.find_by(id: params[:id])
      return redirect_to admins_root_path unless @post.present?
    end

    def set_post_approve
      @post = Post.find_by(id: params[:post_id])
      return redirect_to admins_posts_path if @post.blank?
    end
  end
end
