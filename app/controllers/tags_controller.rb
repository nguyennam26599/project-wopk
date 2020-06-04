# frozen_string_literal: true

class TagsController < ApplicationController
  def search
    @tags = Tag.publish.search_name(params[:term]).limit(5)
    render json: @tags.pluck(:name)
  end
end
