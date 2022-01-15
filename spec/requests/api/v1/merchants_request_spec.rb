require 'rails_helper'

RSpec.describe 'Merchants Request' do
  it 'gets a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end

  it 'can get a single merchants and it\s attributes' do
    create_list(:merchant, 3)

    merchant = Merchant.create!(name: "Bob Burger")

    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]

    expect(merchant[:attributes][:name]).to be_a String
  end

  it "can get an merchant's items" do
    merchant = Merchant.create!(name: "Bob Belcher")
    item = merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    item2 = merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(items.first[:id].to_i).to eq(item.id)
    expect(items.first[:attributes][:name]).to eq(item.name)
    expect(items.first[:attributes][:description]).to eq(item.description)
    expect(items.first[:attributes][:unit_price]).to eq(item.unit_price)
    expect(items.first[:attributes][:merchant_id]).to eq(merchant.id)
  end
end

describe 'sad path' do
  it 'returns an error if no item exists for a merchant' do
    merchant = Merchant.create!(name: "Bob Belcher")

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response.status).to eq(404)

    parsed = JSON.parse(response.body, symbolize_names: true)
    error_msg = parsed[:errors][:details]

    expect(error_msg).to eq("No items available for this merchant")
  end
end
