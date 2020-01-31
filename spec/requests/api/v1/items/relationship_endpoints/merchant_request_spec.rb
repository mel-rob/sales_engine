require 'rails_helper'

RSpec.describe 'single item merchant request' do
  it 'shows merchant for a specific item' do
    merchant = create(:merchant)

    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(merchant.id)
  end
end
