# frozen_string_literal: true

module TagsHelper
  def default_avatar_tag(tag)
    if tag.avatar.blank?
      '/tags_default_avatar.png'
    else
      url_for(tag.avatar)
    end
  end
end
