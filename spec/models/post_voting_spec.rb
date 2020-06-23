# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostVoting, type: :model do
  context 'Record' do
    it 'return a record' do
      post_voting = create(:post_voting)
      expect(PostVoting.find_record(post_voting.user_id, post_voting.post_id)).to be_valid
    end
    it 'delete a record' do
      post_voting = create(:post_voting)
      post_voting.update_record(true)
      expect(PostVoting.find_by(id: post_voting.id).blank?).to be true
    end
    it 'update a record' do
      post_voting = create(:post_voting)
      post_voting.update_record(false)
      expect(PostVoting.find_by(id: post_voting.id).vote == false).to be true
    end
  end
end
