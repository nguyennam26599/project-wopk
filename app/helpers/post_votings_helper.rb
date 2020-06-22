# frozen_string_literal: true

module PostVotingsHelper
  def check_voted(post, vote_in)
    'voted' if user_signed_in? && post.check_vote(current_user, vote_in)
  end
end
