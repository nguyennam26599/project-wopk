# frozen_string_literal: true

module Admins
  class PostsController < BaseController
    before_action :set_post, only: %i[update show destroy]
    add_breadcrumb 'Home', :admins_root_path
    add_breadcrumb 'Posts', :admins_posts_path

    def index
      if params[:scope].nil? || params[:scope] == 'all'
        @posts_list = SearchService.new(params).perform(Post)
        @pagy, @posts = pagy(@posts_list.order(created_at: :desc))
      elsif params[:scope] == 'daily'
        @pagy, @posts = pagy(Post.daily_post_admin)
      else
        @pagy, @posts = pagy(Post.find_post_home_index(params[:scope]))
      end
    end

    def show
      add_breadcrumb @post.title, admins_post_path
      @user = @post.user
      @comment_list = @post.comments.order(created_at: :desc)
    end

    def update
      @post.delete_update_post(:delete)
      redirect_to admins_posts_path
    end

    private

    def set_post
      @post = Post.find_by(id: params[:id])
      return redirect_to admins_posts_path if @post.blank?
    end
  end
end
