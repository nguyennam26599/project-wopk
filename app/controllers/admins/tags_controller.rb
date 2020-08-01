# frozen_string_literal: true

module Admins
  class TagsController < BaseController
    before_action :set_tag, only: %i[show edit update destroy]
    add_breadcrumb 'Home', :admins_root_path
    add_breadcrumb 'Tag', :admins_tags_path

    def index
      @tags_list = SearchService.new(params).perform(Tag)
      @pagy, @tags = pagy(@tags_list.order(created_at: :desc), page: params[:page], items: Tag::NUMBER_ITEM)
    end

    def new
      add_breadcrumb 'New', new_admins_tag_path
      @tag = Tag.new
    end

    def edit
      add_breadcrumb 'Edit', edit_admins_tag_path
    end

    def show
      add_breadcrumb @tag.name, admins_tag_path
      @posts = @tag.posts
    end

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

    def destroy
      return redirect_to admins_tags_path if @tag.destroy
    end

    private

    def tag_params
      params.require(:tag).permit(:name, :avatar).with_defaults(status: 1)
    end

    def set_tag
      @tag = Tag.find_by(id: params[:id])
    end
  end
end
