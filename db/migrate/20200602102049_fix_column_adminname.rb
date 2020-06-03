# frozen_string_literal: true

class FixColumnAdminname < ActiveRecord::Migration[6.0]
  def change
    rename_column :admins, :adminname, :user_name
  end
end
