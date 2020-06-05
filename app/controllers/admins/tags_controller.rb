# frozen_string_literal: true

module Admins
  class TagsController < BaseController
    before_action :set_tags, only: %i[show edit update]

    NUMBER_ITEM = 15

    def index
      @pagy, @tags = pagy(Tag.all.order(created_at: :desc), page: params[:page], items: NUMBER_ITEM)
    end

    def new
      @tag = Tag.new
    end

    def edit; end

    def show; end

    def create
      @tag = Tag.new tag_params
      if @tag.save
        redirect_to admins_tags_path
      else
        render 'new'
      end
    end

    def update
      if @tag.update_attributes(tag_params)
        redirect_to admins_tags_path
      else
        render 'edit'
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:name, :avatar)
    end

    def set_tags
      @tag = Tag.find_by(id: params[:id])
    end
  end
end
