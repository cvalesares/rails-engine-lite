require 'rails_helper'

RSpec.describe 'Merchants Request' do
  it 'gets a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    
    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data].first[:attributes]).to have_key(:id)
    expect(merchants[:data].first[:attributes][:name]).to be_a String
  end
end
