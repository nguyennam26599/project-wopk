# frozen_string_literal: true

class ChangeDefaultColumnForPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :vote, :integer, default: 0
    change_column :posts, :view_count, :integer, default: 0
  end
end
