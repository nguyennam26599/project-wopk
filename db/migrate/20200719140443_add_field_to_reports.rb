# frozen_string_literal: true

class AddFieldToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :status, :integer
  end
end
