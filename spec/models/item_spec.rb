# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'validates name' do
    should validate_presence_of :name
  end

  it 'validates price' do
    should validate_numericality_of :price
  end

  it 'has many' do
    should have_many :positions
    should have_many :carts
    should have_many :comments
  end

  it 'has one' do
    should have_one :image
  end

  context 'calculates the price' do
    let!(:item_1) { create :item, price: 10 }
    let!(:item_2) { create :item, price: 20 }
    let!(:order) { create :order }

    it 'calculates the price' do
      order.items << item_1
      order.items << item_2

      order.calculate_total
      expect(order.total).to be 30.0
    end
  end
end