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

  xit 'can get a merchant\'s items' do
    merchant = Merchant.create!(name: "Bob Burger")
    merchant2 = Merchant.create!(name: "Linda Belcher")
    item = merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    item2 = merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)
    item3 = merchant2.items.create!(name: "rock", description: "not pointy", unit_price: 0)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    binding.pry


  end
end
