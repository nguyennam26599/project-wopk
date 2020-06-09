# frozen_string_literal: true

module HomeHelper
  def fa_icon(i_class, text)
    "<i class='#{i_class}'></i> #{text}".html_safe
  end
end
