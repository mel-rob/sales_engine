require 'rails_helper'

RSpec.describe 'single invoice item item request' do
  it 'shows item for a specific invoice item' do
    item = create(:item)

    invoice_item = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(item.id)
  end
end
