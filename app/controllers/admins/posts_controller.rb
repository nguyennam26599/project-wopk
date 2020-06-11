# frozen_string_literal: true

module Admins
  class PostsController < BaseController
    def index
      scope_post = params[:scope]
      scope_post ||= 'pending'
      @pagy, @posts = pagy(Post.where(status: scope_post))
    end
  end
end
