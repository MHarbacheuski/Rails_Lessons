# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Position, type: :model do
  # it 'belongs too' do
  #   should belong_to :cart
  #   should belong_to :item
  # end
  it { should belong_to :cart}
  it { should belong_to :item}
end
