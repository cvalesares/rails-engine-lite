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

  it 'can get a single item and it\'s attributes' do

    get "/api/v1/items/#{@item.id}"
    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    item = parsed[:data]

    expect(item[:attributes][:name]).to be_a String
    expect(item[:attributes][:name]).to eq("sword")
    expect(item[:attributes][:description]).to be_a String
    expect(item[:attributes][:description]).to eq("pointy")
    expect(item[:attributes][:unit_price]).to be_a Float
    expect(item[:attributes][:unit_price]).to eq(32.0)
    expect(item[:attributes][:merchant_id]).to be_a Integer
    expect(item[:attributes][:merchant_id]).to eq(@merchant.id)
  end

  it 'can create a new item' do
    item_params = {
                    name: 'Mace',
                    description: 'many pointy bits',
                    unit_price: 34,
                    merchant_id: @merchant.id
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last
    expect(response.status).to eq(201)

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end
end
