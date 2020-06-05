# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'returns tag that match the search name and status' do
    tag2 = Tag.create(
      name: 'This is the second tag.',
      status: 'publish'
    )
    expect(Tag.search_name_status_public('This')).to include(tag2)
  end
end
