# frozen_string_literal: true

class CreatePostVotings < ActiveRecord::Migration[6.0]
  def change
    create_table :post_votings do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.boolean :vote, default: true
      t.timestamps
    end
  end
end
