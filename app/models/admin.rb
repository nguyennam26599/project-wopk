# frozen_string_literal: true

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]
  attr_writer :login

  def login
    @login || user_name || email
  end

  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(['user_name = :value OR email = :value', { value: login }]).first
  end
end
