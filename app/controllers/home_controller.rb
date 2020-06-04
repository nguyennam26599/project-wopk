# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end
end
