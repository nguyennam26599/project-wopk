# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  enum status: %i[show hide], _prefix: true

  NUMBER_COMMENTS_5 = 5
  SHOW_STATUS = 'show'
  HIDE_STATUS = 'hide'
end
