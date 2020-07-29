# frozen_string_literal: true

class AddDarkModeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :darkmode, :integer, default: 0
  end
end
