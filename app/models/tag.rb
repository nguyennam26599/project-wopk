# frozen_string_literal: true

class Tag < ApplicationRecord
  before_save :downcase_name

  has_many :posts_relationships, as: :posts_relationship
  has_many :posts, through: :posts_relationships
  enum status: %i[draft publish]

  PUBLISH_STATUS = 'publish'
  DRAFT_STATUS = 'draft'

  scope :search_name, ->(search_word) { where('name LIKE ?', "%#{search_word}%") }

  private

  def downcase_name
    name.downcase!
  end
end
