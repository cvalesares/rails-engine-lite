require 'rails_helper'

RSpec.describe "Item Search" do
  before :each do
    @merchant = Merchant.create!(name: "Bob Belcher")
    @merchant2 = Merchant.create!(name: "Linda Belcher")
    @item = @merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    @item2 = @merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)
    @item3 = @merchant2.items.create!(name: "wooden sword", description: "pointy with splinters", unit_price: 11)
  end

  it 'can find all items by name fragment' do
    get "/api/v1/items/find_all?name=word"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(items.count).to eq(2)
    expect(items[0][:id].to_i).to eq(@item.id)
    expect(items[0][:attributes][:name]).to eq(@item.name)
    expect(items[0][:attributes][:description]).to eq(@item.description)
    expect(items[0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(items[1][:id].to_i).to eq(@item3.id)
    expect(items[1][:attributes][:name]).to eq(@item3.name)
    expect(items[1][:attributes][:description]).to eq(@item3.description)
    expect(items[1][:attributes][:unit_price]).to eq(@item3.unit_price)
  end
end

describe "sad path" do
  it 'returns and error if no match' do
    get "/api/v1/items/find_all?name=xf"

    expect(response.status).to eq(404)

    parsed = JSON.parse(response.body, symbolize_names: true)
    error_msg = parsed[:data][:details]
    
    expect(error_msg).to eq("No item matches this name")
  end
end
