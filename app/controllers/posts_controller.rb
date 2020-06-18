# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, :set_posts, only: %i[new create edit update]
  before_action :set_post, only: %i[edit update]
  before_action :current_post, only: %i[view show]

  def index; end

  def new
    @post = @posts.new
  end

  def create
    return redirect_to new_post_path unless Post.valid_status?(params[:post][:status])

    @post = @posts.new post_params
    if @post.save
      @post.check_list_tag(params[:tags])
      redirect_to @post
    else
      redirect_to new_post_path
    end
  end

  def show
    @user = @post.user
  end

  def edit; end

  def update
    return redirect_to edit_post_path unless Post.valid_status?(params[:post][:status])

    if @post.update_process post_params
      @post.check_list_tag(params[:tags])
      redirect_to @post
    else
      redirect_to new_post_path
    end
  end

  # view count
  def view
    if @post.view_increment
      render json: { status: true, post_view: @post.view_count }
    else
      render json: { status: false }
    end
  end

  private

  def current_post
    @post = Post.find_by(id: params[:id])
    return redirect_to(root_url, notice: 'Post is not found') unless @post.present?
  end

  def post_params
    params.require(:post).permit(:title, :content, :status)
  end

  def set_posts
    @posts = current_user.posts
  end

  def set_post
    @post = @posts.find_by(id: params[:id])
    return redirect_to root_path unless @post.present?
  end
end
