# frozen_string_literal: true

class AddPublishAtToPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :publish_at, :datetime
  end
end
