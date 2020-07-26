# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :reports, as: :reportable
  has_many :comments
  has_many :posts_relationships
  has_many :tags, through: :posts_relationships, source: :posts_relationship, source_type: 'Tag'
  belongs_to :user
  enum status: %i[draft public delete], _prefix: true
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
  scope :daily, -> { status_public.order(created_at: :desc).order(view_count: :desc) }
  scope :weekly, -> { status_public.this_week.order(view_count: :desc) }
  scope :monthly, -> { status_public.this_month.order(view_count: :desc) }

  scope :post_followings,
        lambda { |user|
          joins(:tags)
            .status_public
            .where('tags.id in (?) or user_id in (?)', user.tag_followings.ids, user.user_followings.ids)
            .order(created_at: :desc)
            .group(:id)
        }
  scope :search_title_status_public, ->(search_word) { status_public.where('title LIKE ?', "%#{search_word}%") }
  scope :search_by_key_word,
        lambda { |word_search|
          where('id LIKE :search OR title LIKE :search', search: "%#{word_search}%")
        }
  scope :search_by_status, ->(status_post) { where('status = ?', status_post) }
  # User follow Post
  has_many :followers, as: :following, class_name: 'FollowPolymorphic'
  has_many :user_followings, through: :followings, source: :following, source_type: 'User'
  has_rich_text :content

  DRAFT_STATUS = 'draft'
  DELETE_STATUS = 'delete'
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
    [PUBLIC_STATUS, DRAFT_STATUS].include?(status)
  end

  def update_process(post_params)
    posts_relationships.destroy_all
    update post_params
  end

  def edit_able?(user_input)
    user == user_input
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

  def self.find_post_current_user(scope_post)
    if scope_post == DRAFT_STATUS
      status_draft
    elsif scope_post == DELETE_STATUS
      status_delete
    else
      status_public
    end
  end

  # increment view
  def view_increment
    increment!(:view_count)
  end

  def delete_update_post(status_update)
    update(status: status_update)
  end

  # check_vote
  def check_vote(user, vote_in)
    post_votings.find_by(user_id: user.id, vote: vote_in)
  end

  def search
    @posts = Post.search_title_status_public(params[:search]).limit(10)
    render json: @posts.pluck(:title)
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
