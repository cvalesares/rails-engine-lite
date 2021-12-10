require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'can find all items by name' do
    merchant = Merchant.create!(name: "Bob Belcher")
    merchant2 = Merchant.create!(name: "Linda Belcher")
    item = merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    item2 = merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)
    item3 = merchant2.items.create!(name: "wooden sword", description: "pointy with splinters", unit_price: 11)

    expect(Item.find_all_by_name("word")).to eq([item, item3])
  end
end
