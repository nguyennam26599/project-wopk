# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @posts = Post.all
    @user = User.find_by(id: params[:id])
  end
end
