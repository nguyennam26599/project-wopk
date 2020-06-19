# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  has_many :posts_relationships
  has_many :tags, through: :posts_relationships, source: :posts_relationship, source_type: 'Tag'
  belongs_to :user
  enum status: %i[draft pending public close], _prefix: true
  scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  scope :this_week, -> { where(created_at: Time.now.beginning_of_week..Time.now) }
  # has many users through postvoting
  has_many :post_votings
  # Sort by latest posts
  scope :sort_new_post, -> { order(created_at: :desc) }
  # Sort posts most views
  scope :sort_trend_post, -> { order(view_count: :desc) }
  # Show posts most views in the pending status for the month
  scope :top_post_public_this_month,
        lambda {
          where(created_at: Time.now.beginning_of_month..Time.now.end_of_month, status: PUBLIC_STATUS)
            .order(view_count: :desc)
        }
  # Show posts most views in the pending status for the week.
  # Default beginning_of_week is monday
  scope :top_post_public_this_week,
        lambda {
          where(created_at: Time.now.beginning_of_week..Time.now, status: PUBLIC_STATUS)
            .order(view_count: :desc)
        }
  # Post index
  scope :daily, -> { status_public.order(publish_at: :desc).order(view_count: :desc) }
  scope :weekly, -> { status_public.this_week.order(view_count: :desc) }
  scope :monthly, -> { status_public.this_month.order(view_count: :desc) }

  # User follow Post
  has_many :followers, as: :following, class_name: 'FollowPolymorphic'
  has_many :user_followings, through: :followings, source: :following, source_type: 'User'

  PENDING_STATUS = 'pending'
  DRAFT_STATUS = 'draft'
  CLOSE_STATUS = 'close'
  PUBLIC_STATUS = 'public'

  DAILY_POST = 'daily'
  WEEKLY_POST = 'weekly'
  MONTHLY_POST = 'monthly'

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

    if status_draft?
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

  def edit_able?(user_input)
    user == user_input && !status_public?
  end

  def self.find_post_home_index(scope_post)
    if scope_post == WEEKLY_POST
      weekly
    elsif scope_post == MONTHLY_POST
      monthly
    else
      daily
    end
  end

  # increment view
  def view_increment
    increment!(:view_count)
  end

  def approve_update_post(status_update)
    approve_date = Time.now if status_update == PUBLIC_STATUS
    update(status: status_update, publish_at: approve_date)
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
