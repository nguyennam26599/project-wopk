# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true, length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z0-9]+\z/ },
                   uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  enum gender: %i[male female other]
  enum status: %i[deactived actived blocked]
  has_many :posts
  has_many :comments
  has_many :followings, as: :follower, class_name: 'FollowPolymorphic'
  has_many :followers, as: :following, class_name: 'FollowPolymorphic'
  has_many :user_followers, through: :followers, source: :follower, source_type: 'User'
  has_many :user_followings, through: :followings, source: :following, source_type: 'User'
  has_many :tag_followings, through: :followings, source: :following, source_type: 'Tag'
  has_many :post_followings, through: :followings, source: :following, source_type: 'Post'
  has_one_attached :avatar
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # has many post through postvoting
  has_many :post_votings
  has_many :reports
  attr_writer :login
  scope :leaderboard_user_posts, lambda {
                                   joins(:posts).select('users.*, count(posts.id) as total')
                                                .where('posts.status = 1').group(:id).order('total DESC')
                                                .limit(NUMBER_ITEM_10)
                                 }
  scope :search_by_key_word, lambda { |word_search|
                               where('id LIKE :search
                                              OR name LIKE :search
                                              OR last_name LIKE :search
                                              OR first_name LIKE :search
                                              OR email LIKE :search', search: "%#{word_search}%")
                             }
  scope :search_by_status, ->(status_user) { where('status = ?', status_user) }

  NUMBER_ITEM_10 = 10

  ACTIVED_STATUS = 'actived'
  DEACTIVED_STATUS = 'deactived'
  BLOCKED_STATUS = 'blocked'

  def login
    @login || name || email
  end

  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(['name = :value OR email = :value', { value: login }]).first
  end

  def post_size
    posts.size
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def link_github
    "http://github.com/#{github_link}"
  end

  def link_facebook
    "http://facebook.com/#{facebook_link}"
  end

  def link_linkedin
    "https://www.linkedin.com/#{linkedln_link}"
  end

  def send_gmail
    "https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=#{email}"
  end

  def link_url
    "http://#{url_link}"
  end

  def following?(other_user)
    user_followings.include?(other_user)
  end

  # check user status authenticantion
  def active_for_authentication?
    super && actived?
  end

  def post_size_public
    posts.status_public.size
  end

  private

  # after action email confirm
  def after_confirmation
    user_status_update
  end

  # update user status
  def user_status_update
    actived! if confirmed? && deactived?
  end
end
