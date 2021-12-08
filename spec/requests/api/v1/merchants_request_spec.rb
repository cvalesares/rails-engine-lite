require 'rails_helper'

RSpec.describe 'Merchants Request' do
  it 'gets a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(3)
    expect(merchants.first).to have_key(:id)
    expect(merchants.first[:name]).to be_a String
  end
end
