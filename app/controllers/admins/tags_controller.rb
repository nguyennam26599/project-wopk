# frozen_string_literal: true

module Admins
  class TagsController < BaseController
    before_action :set_tag, only: %i[show edit update]

    def index
      @pagy, @tags = pagy(Tag.all.order(created_at: :desc), page: params[:page], items: Tag::NUMBER_ITEM)
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
        render :new
      end
    end

    def update
      if @tag.update_attributes(tag_params)
        redirect_to admins_tags_path
      else
        render :new
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:name, :avatar)
    end

    def set_tag
      @tag = Tag.find_by(id: params[:id])
    end
  end
end
