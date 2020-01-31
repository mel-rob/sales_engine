require 'rails_helper'

RSpec.describe 'single item invoice items request' do
  it 'shows all invoice items for a specific item' do
    item = create(:item)

    invoice_item_1 = create(:invoice_item, item_id: item.id)
    invoice_item_2 = create(:invoice_item, item_id: item.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].length).to eq(2)
    expect(invoice_items['data'].first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items['data'].last['attributes']['id']).to eq(invoice_item_2.id)
  end
end
