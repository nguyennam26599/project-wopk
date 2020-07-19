# frozen_string_literal: true

module PostsHelper
  def tagsinput_data(post)
    post.tags.pluck(:name).join(',')
  end

  def button_clip_post_check
    'bg-info text-white' if current_user.post_followings.exists?(id: @post.id)
  end

  def user_create_post?(post)
    current_user != post.user
  end
end
