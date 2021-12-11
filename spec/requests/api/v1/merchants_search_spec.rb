require 'rails_helper'

RSpec.describe "Merchant Search" do
  before :each do
    @merchant = Merchant.create!(name: "Bob Belcher")
    @merchant2 = Merchant.create!(name: "Rob Berto")
    @merchant3 = Merchant.create!(name: "John Smith")
    @item = @merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    @item2 = @merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)
  end

  it "can find a merchant by name fragment" do
    get "/api/v1/merchants/find?name=ob"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]

    expect(merchant[:id].to_i).to eq(@merchant.id)
    expect(merchant[:attributes][:name]).to eq(@merchant.name)
  end

  it "can find all merchants by name fragment" do
    #make sure this is the correct uri for this endpoint
    get "/api/v1/merchants/find/all?name=ob"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(merchants.count).to eq(2)
    expect(merchants[0][:id].to_i).to eq(@merchant.id)
    expect(merchants[0][:attributes][:name]).to eq(@merchant.name)
    expect(merchants[1][:id].to_i).to eq(@merchant2.id)
    expect(merchants[1][:attributes][:name]).to eq(@merchant2.name)
  end
end

describe "sad path" do
  it 'returns an error message if no match for find' do
    merchant = Merchant.create!(name: "Bob Belcher")
    merchant2 = Merchant.create!(name: "Rob Berto")
    merchant3 = Merchant.create!(name: "John Smith")
    item = merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    item2 = merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)

    get "/api/v1/merchants/find?name=mary"

    expect(response.status).to eq(404)

    parsed = JSON.parse(response.body, symbolize_names: true)
    error_msg = parsed[:data][:details]

    expect(error_msg).to eq("No merchant matches this name")
  end

  it 'returns an error message if no match for find all' do
    merchant = Merchant.create!(name: "Bob Belcher")
    merchant2 = Merchant.create!(name: "Rob Berto")
    merchant3 = Merchant.create!(name: "John Smith")
    item = merchant.items.create!(name: "sword", description: "pointy", unit_price: 32)
    item2 = merchant.items.create!(name: "shield", description: "not pointy", unit_price: 30)

    get "/api/v1/merchants/find/all?name=mary"

    expect(response.status).to eq(404)

    parsed = JSON.parse(response.body, symbolize_names: true)
    error_msg = parsed[:data][:details]

    expect(error_msg).to eq("No merchant(s) match this name")
  end
end
