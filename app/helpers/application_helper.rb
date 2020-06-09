# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  NUMBER_PAGE = 15

  def active?(controller)
    'active' if params[:controller] == controller
  end
end
