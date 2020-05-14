# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :name, presence: true

  has_many :posts
  has_many :comments
  has_many :followings, as: :follower, class_name: 'FollowPolymorphic'
  has_many :followers, as: :following, class_name: 'FollowPolymorphic'
  has_many :user_followers, through: :followers, source: :follower, source_type: 'User'
  has_many :user_followings, through: :followings, source: :following, source_type: 'User'
  has_many :tag_followings, through: :followings, source: :following, source_type: 'Tag'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
