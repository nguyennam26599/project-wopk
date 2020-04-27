# frozen_string_literal: true

class AddFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :address, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :integer
    add_column :users, :status, :integer
  end
end
