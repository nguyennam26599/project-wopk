# frozen_string_literal: true

module PostsHelper
  def tagsinput_data(post)
    post.tags.pluck(:name).join(',')
  end
end
