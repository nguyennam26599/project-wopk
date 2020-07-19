# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :reportable_id
      t.string :reportable_type
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
