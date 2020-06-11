# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  has_many :posts_relationships
  has_many :tags, through: :posts_relationships, source: :posts_relationship, source_type: 'Tag'
  belongs_to :user
  enum status: %i[draft pending]
  scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  scope :this_week, -> { where(created_at: Time.now.beginning_of_week..Time.now) }
  # has many users through postvoting
  has_many :post_votings

  PENDING_STATUS = 'pending'
  DRAFT_STATUS = 'draft'

  def vote_count
    if vote.positive?
      "+#{vote}"
    elsif vote.negative?
      vote.to_s
    else
      '0'
    end
  end

  def check_list_tag(name_tag_list)
    return if name_tag_list.blank?

    if draft?
      create_tag_relationship(name_tag_list, Tag::DRAFT_STATUS)
    else
      create_tag_relationship(name_tag_list, Tag::PUBLISH_STATUS)
    end
  end

  def self.valid_status?(status)
    [PENDING_STATUS, DRAFT_STATUS].include?(status)
  end

  def update_process(post_params)
    posts_relationships.destroy_all
    update post_params
  end

  def belong_user?(user_input)
    user == user_input
  end

  private

  def create_tag_relationship(name_tag_list, status)
    name_tag_list.split(',').each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.downcase)
      tag.update(status: status)
      posts_relationships.create(posts_relationship: tag)
    end
  end
end
