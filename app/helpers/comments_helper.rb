# frozen_string_literal: true

module CommentsHelper
  def check_user_comment(comment)
    comment.user == current_user
  end

  def check_status_comment(comment)
    'border-danger border' if comment.status_hide?
  end
end
