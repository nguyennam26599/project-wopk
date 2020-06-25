# frozen_string_literal: true

module TagsHelper
  def default_avatar_tag(tag)
    if tag.avatar.blank?
      '/tags_default_avatar.png'
    else
      url_for(tag.avatar)
    end
  end

  def check_follow_status_color(tag)
    FollowPolymorphic.find_by(follower: current_user, following: tag).blank? ? 'btn-success' : 'btn-danger'
  end

  def check_follow_status_text(tag)
    FollowPolymorphic.find_by(follower: current_user, following: tag).blank? ? 'Follow' : 'Unfollow'
  end
end
