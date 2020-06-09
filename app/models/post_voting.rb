# frozen_string_literal: true

class PostVoting < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
