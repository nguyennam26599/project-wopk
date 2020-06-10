# frozen_string_literal: true

module PostsHelper
  def edit_or_report_post
    if current_user == Post.find_by(id: params[:id]).user
      link_to 'Edit', edit_post_path, class: 'text-dark'
    else
      link_to 'Report', '#', class: 'text-dark'
    end
  end
end
