# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  belongs_to :user
  enum status: %i[Spam Copyright], _prefix: true

  DELETE_STATUS = 'delete'
end
