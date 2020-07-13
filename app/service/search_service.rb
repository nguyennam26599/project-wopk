# frozen_string_literal: true

class SearchService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def perform
    users = search_by_status(User.all)
    search_by_key_word(users)
  end

  private

  def search_by_status(users)
    return users if status_param.blank?

    users.search_by_status(status_param)
  end

  def search_by_key_word(users)
    return users if search_param.blank?

    users.search_by_key_word(search_param)
  end

  def search_param
    params[:search]
  end

  def status_param
    params[:status]
  end
end
