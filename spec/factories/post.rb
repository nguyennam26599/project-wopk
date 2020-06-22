# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    before(:create) do |post|
      user = create(:user)
      post.user = user
    end
  end
end
