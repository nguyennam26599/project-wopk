# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def set_default_image(tag)
    if tag.avatar.blank?
      '/images/default-tag.png'
    else
      url_for(tag.avatar)
    end
  end
end
