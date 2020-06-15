# frozen_string_literal: true

class AddDefaultStatusColumnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :status, :integer, default: 0
  end
end
