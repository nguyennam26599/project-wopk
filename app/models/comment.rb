# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  enum status: %i[show hide], _prefix: true

  NUMBER_COMMENTS_5 = 5
  SHOW_STATUS = 'show'
  HIDE_STATUS = 'hide'
  scope :search_by_status, ->(status_comment) { where('status = ?', status_comment) }
  scope :search_by_key_word, lambda { |word_search|
                                where('id LIKE :search OR content LIKE :search', search: "%#{word_search}%")
                              }
end
