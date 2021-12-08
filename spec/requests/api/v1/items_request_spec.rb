require 'rails_helper'

RSpec.describe 'Items Request' do
  before :each do
    @merchant = Merchant.create!(name: "Bob Belcher")
    @item = @merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    @item2 = @merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)
  end

  it 'gets a list of all items' do

    get '/api/v1/items'
    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(items.count).to eq(2)
    expect(items.first[:attributes][:name]).to be_a String
    expect(items.first[:attributes][:name]).to eq("sword")
    expect(items.first[:attributes][:description]).to be_a String
    expect(items.first[:attributes][:description]).to eq("pointy")
    expect(items.first[:attributes][:unit_price]).to be_a Float
    expect(items.first[:attributes][:unit_price]).to eq(32.0)
    expect(items.first[:attributes][:merchant_id]).to be_a Integer
    expect(items.first[:attributes][:merchant_id]).to eq(@merchant.id)

  end
end
