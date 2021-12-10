require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it 'can find a single merchant by name' do
    merchant = Merchant.create!(name: "Bob Belcher")
    merchant2 = Merchant.create!(name: "Rob Berto")
    merchant3 = Merchant.create!(name: "John Smith")
    item = merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    item2 = merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)

    expect(Merchant.find_by_name("ob")).to eq(merchant)
  end
end
