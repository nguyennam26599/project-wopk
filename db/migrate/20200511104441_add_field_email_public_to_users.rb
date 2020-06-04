# frozen_string_literal: true

class AddFieldEmailPublicToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_public, :boolean
  end
end
