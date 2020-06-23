# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test@nal.vn' }
    password { '123456' }
    first_name { 'Hoang' }
    last_name { 'Anh' }
  end
end
