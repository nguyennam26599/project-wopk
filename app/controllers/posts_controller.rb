# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, :set_posts, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[edit update destroy]
  before_action :current_post, only: %i[view show]
  before_action :delete_relationship, :delete_comment, only: :destroy

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
    @comments = @post.comments.status_show
    @newest_comment_list = @comments.order('created_at DESC')
    @report = Report.new
    # @newest_comment_list = @comments.order('created_at DESC').limit(Comment::NUMBER_COMMENTS_5)
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
      render json: { status: true, post_view: @post.view_count, read_time: reading_time(@post.content) }
    else
      render json: { status: false }
    end
  end

  def destroy
    if @post.status_public?
      return redirect_to root_path if @post.destroy
    else
      @tags.each do |tag_item|
        tag_item.destroy if tag_item.draft?
      end
      return redirect root_path if @post.destroy
    end
  end

  private

  def current_post
    @post = Post.find_by(id: params[:id])
    return redirect_to(root_url, notice: 'Post is not found') if @post.blank?
    return @post if @post.user == current_user
    return redirect_to(root_url, notice: 'Post is not found') unless @post.status_public?
  end

  def post_params
    params.require(:post).permit(:title, :content, :status)
  end

  def set_posts
    @posts = current_user.posts
  end

  def set_post
    @post = @posts.find_by(id: params[:id])
    return redirect_to(root_url, alert: 'Post posted') if @post.blank?
  end

  def delete_relationship
    @post.posts_relationships.destroy_all
    @tags = @post.tags
  end

  def delete_comment
    @post.comments.destroy_all
  end

  def reading_time(post)
    post.to_s.scan(/[\w-]+/).size / 265 + 1
  end
end
