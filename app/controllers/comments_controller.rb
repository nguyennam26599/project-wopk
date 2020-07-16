# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[create index]

  def index
    @pagy, @comments = pagy(@post.comments.order('created_at DESC'), page: params[:page], items: NUMBER_PAGE_5)
    list_comment = @comments.map { |comment| CommentSerializer.new(comment).as_json }
    # comment_html = render_to_string(partial: 'comments/loadmore_comment', layout: false)
    render json: { status: true, list_comment: list_comment, number_comment: Comment::NUMBER_COMMENTS_5 }
  end

  def create
    @comment = Comment.new(comment_params)
    return unless @comment.save

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @post =  Post.find_by(id: @comment.post_id)
    if @comment.update content: params[:comment][:content]
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(id: params[:post_id]) }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
