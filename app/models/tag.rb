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
  validates :avatar, allow_blank: true, attached: true, content_type: %i[gif jpg jpeg png pdf tif]
  PUBLISH_STATUS = 'publish'
  DRAFT_STATUS = 'draft'
  NUMBER_ITEM = 15
  NUMBER_ITEM_10 = 10
  scope :search_name_status_public, ->(search_word) { publish.where('name LIKE ?', "%#{search_word}%") }
  scope :leaderboard_tags_posts, lambda {
                                   joins(:posts).select('tags.*, count(posts.id) as total')
                                                .where('posts.status = 1').group(:id).order('total DESC')
                                                .limit(NUMBER_ITEM_10)
                                 }
  scope :search_by_key_word, lambda { |word_search|
                               where('id LIKE :search OR name LIKE :search', search: "%#{word_search}%")
                             }
  scope :search_by_status, ->(status_tag) { where('status = ?', status_tag) }
  def tag_post_size
    posts.status_public.size
  end

  def tag_follower_size
    followers.size
  end

  def self.find_tag(tag_id)
    find_by(id: tag_id)
  end

  private

  def downcase_name
    name.downcase!
  end
end
