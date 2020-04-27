# frozen_string_literal: true

class AddRefUserToPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
