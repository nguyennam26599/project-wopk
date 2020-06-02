# frozen_string_literal: true

class PostsController < ApplicationController
  def show
    if (@post = Post.find_by(id: params[:id]))
      @user = @post.user
    else
      redirect_to(root_url, notice: 'Post is not found')
    end
  end
end
