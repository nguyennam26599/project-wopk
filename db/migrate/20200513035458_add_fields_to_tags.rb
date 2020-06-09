# frozen_string_literal: true

class AddFieldsToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :avatar, :string
  end
end
