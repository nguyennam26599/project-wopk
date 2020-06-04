# frozen_string_literal: true

class AddStatusToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :status, :integer
  end
end
