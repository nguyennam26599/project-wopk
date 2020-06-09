# frozen_string_literal: true

class Tag < ApplicationRecord
  before_save :downcase_name

  has_many :posts_relationships, as: :posts_relationship
  has_many :posts, through: :posts_relationships
  has_one_attached :avatar
  enum status: %i[draft publish]
  # User follow Tag
  has_many :followers, as: :following, class_name: 'FollowPolymorphic'
  has_many :user_followings, through: :followings, source: :following, source_type: 'User'
  scope :tag_list_order_follower, -> { left_joins(:followers).group(:id).order('COUNT(follow_polymorphics.id) DESC') }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  PUBLISH_STATUS = 'publish'
  DRAFT_STATUS = 'draft'
  NUMBER_ITEM = 15
  scope :search_name_status_public, ->(search_word) { publish.where('name LIKE ?', "%#{search_word}%") }

  def tag_post_size
    posts.size
  end

  def tag_follower_size
    followers.size
  end

  private

  def downcase_name
    name.downcase!
  end
end
