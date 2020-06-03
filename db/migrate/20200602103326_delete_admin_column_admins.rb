# frozen_string_literal: true

class DeleteAdminColumnAdmins < ActiveRecord::Migration[6.0]
  def change
    remove_column :admins, :admin
  end
end
