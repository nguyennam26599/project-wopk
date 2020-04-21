# frozen_string_literal: true

class AddRefPostToPostsRelationship < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts_relationships, :post, null: false, foreign_key: true
  end
end
