# frozen_string_literal: true

class ChangeDataTypeForContentPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :content, :text
  end
end
