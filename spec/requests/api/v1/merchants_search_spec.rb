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
end

describe "sad path" do
  it 'returns an error message if no match' do
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
end
