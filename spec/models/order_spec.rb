# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'belongs too' do
    should belong_to :user
  end

end