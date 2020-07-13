# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :avatar_url, :url

  def avatar_url
    if object.avatar.attached?
      rails_blob_path(object.avatar, disposition: 'attachment', only_path: true)
    else
      '/default-user-avatar.png'
    end
  end

  def url
    user_path(object)
  end
end
