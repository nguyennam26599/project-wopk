# frozen_string_literal: true

module Admins
  class CommentsController < BaseController
    def index; end

    def edit; end

    def update
      @comment = Comment.find_by(id: params[:id])
      @comment.update status: params[:comment_status]
      redirect_to admins_post_path(@comment.post)
    end
  end
end
