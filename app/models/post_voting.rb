# frozen_string_literal: true

class PostVoting < ApplicationRecord
  after_create :update_vote
  after_update :update_vote
  after_destroy :update_vote

  belongs_to :user
  belongs_to :post

  def self.voting(user_id, post_id, vote_in)
    if find_record(user_id, post_id).present?
      find_record(user_id, post_id).update_record(vote_in)
    else
      create(user_id: user_id, post_id: post_id, vote: vote_in)
    end
  end

  def update_record(vote_in)
    if vote == vote_in
      destroy
    else
      update(vote: vote_in)
    end
  end

  def self.find_record(user_id, post_id)
    find_by(user_id: user_id, post_id: post_id)
  end

  def self.check_vote?(obj)
    obj.to_s.downcase == 'true'
  end

  private

  def update_vote
    post.update(vote: vote_size)
  end

  def vote_size
    upvote_size - downvote_size
  end

  def upvote_size
    post.post_votings.where(vote: true).size
  end

  def downvote_size
    post.post_votings.where(vote: false).size
  end
end
