# frozen_string_literal: true

module Admins
  class PostsController < BaseController
    before_action :set_post, only: %i[update show]
    add_breadcrumb 'Home', :admins_root_path
    add_breadcrumb 'Posts', :admins_posts_path

    def index
      @pagy, @posts = pagy(Post.all)
    end

    def show
      add_breadcrumb @post.title, admins_post_path
      @user = @post.user
      @comment_list = @post.comments.order(created_at: :desc)
    end

    def update
      @post.approve_update_post(params[:approve_status])
      redirect_to admins_posts_path
    end

    private

    def set_post
      @post = Post.find_by(id: params[:id])
      return redirect_to admins_posts_path if @post.blank?
    end
  end
end
