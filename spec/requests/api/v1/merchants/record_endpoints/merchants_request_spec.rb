require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'returns an index of all merchant records' do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']

    expect(merchants.count).to eq(10)
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['id']).to eq(id)
  end
end
