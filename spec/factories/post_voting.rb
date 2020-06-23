# frozen_string_literal: true

FactoryBot.define do
  factory :post_voting do
    before(:create) do |post_voting|
      post = create(:post)
      post_voting.user = post.user
      post_voting.post = post
    end
    vote { true }
  end
end
