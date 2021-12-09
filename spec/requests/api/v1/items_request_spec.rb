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

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last
    expect(response.status).to eq(201)

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end


  it "can update an existing item" do
    item3 = @merchant.items.create!(name: 'mace', description: 'many pointy bits', unit_price: 34)
    previous_name = Item.last.name
    previous_description = Item.last.description
    item_params = { name: "chain mace", description: 'many pointy bits with chain' }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item3.id}", headers: headers, params: JSON.generate(item_params)

    expect(response).to be_successful
    expect(Item.last.name).to_not eq(previous_name)
    expect(Item.last.name).to eq("chain mace")
    expect(Item.last.description).to_not eq(previous_description)
    expect(Item.last.description).to eq('many pointy bits with chain')
  end

  it "can destroy an book" do
    item3 = @merchant.items.create!(name: 'chain mace', description: 'many pointy bits with chain', unit_price: 34)

    expect(Item.count).to eq(3)

    delete "/api/v1/items/#{item3.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(2)
    expect{Item.find(item3.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can get an item's merchant" do

    get "/api/v1/items/#{@item.id}/merchant"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]

    expect(merchant[:id].to_i).to eq(@merchant.id)
    expect(merchant[:attributes][:name]).to eq(@merchant.name)
  end
end
