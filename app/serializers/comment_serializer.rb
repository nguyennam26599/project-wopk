# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :content, :time_ago

  belongs_to :user
  def time_ago
    time_ago_in_words(object.created_at)
  end
end
