# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  enum status: %i[public draft], _prefix: true

  NUMBER_COMMENTS_5 = 5
end
