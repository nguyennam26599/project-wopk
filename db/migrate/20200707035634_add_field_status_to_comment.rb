# frozen_string_literal: true

class AddFieldStatusToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :status, :integer, default: 0
  end
end
