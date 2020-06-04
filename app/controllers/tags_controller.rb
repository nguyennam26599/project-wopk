# frozen_string_literal: true

class TagsController < ApplicationController
  def search
    @tags = Tag.search_name_status_public(params[:term]).limit(5)
    render json: @tags.pluck(:name)
  end
end
