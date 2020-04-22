# frozen_string_literal: true

class CreatePostsRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :posts_relationships do |t|
      t.integer :posts_relationship_id
      t.string :posts_relationship_type

      t.timestamps
    end
  end
end
