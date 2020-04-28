# frozen_string_literal: true

class AddField2ToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :facebook_link, :string
    add_column :users, :github_link, :string
    add_column :users, :linkedln_link, :string
    add_column :users, :url_link, :string
    add_column :users, :description, :string
    add_column :users, :organization, :string
  end
end
