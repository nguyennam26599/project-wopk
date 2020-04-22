# frozen_string_literal: true

class CreateFollowUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_users do |t|
      t.integer :follower
      t.integer :following

      t.timestamps
    end
  end
end
