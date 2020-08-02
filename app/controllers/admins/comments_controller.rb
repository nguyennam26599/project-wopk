# frozen_string_literal: true

module Admins
  class CommentsController < BaseController
    def index
      @comments_list = SearchService.new(params).perform(Comment)
      @pagy, @comments = pagy(@comments_list.order(created_at: :desc))
    end

    def edit; end

    def update
      @comment = Comment.find_by(id: params[:id])
      @comment.update status: params[:comment_status]
      redirect_to admins_post_path(@comment.post)
    end

    def destroy
      @comment = Comment.find_by(id: params[:id])
      @comment.update status: params[:comment_status]
      redirect_to admins_comments_path(@comment)
    end
  end
end
