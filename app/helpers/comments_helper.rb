# frozen_string_literal: true

module CommentsHelper
    def check_user_comment(comment)
        comment.user == current_user
    end
end
