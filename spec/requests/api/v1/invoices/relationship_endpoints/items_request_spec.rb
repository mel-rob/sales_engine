require 'rails_helper'

RSpec.describe 'single invoice items request' do
  it 'shows all items for a specific invoice' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    item_1 = create(:item)
    item_2 = create(:item)

    invoice_items_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id)
    invoice_items_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id)
    invoice_items_3 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id)

    get "/api/v1/invoices/#{invoice_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].length).to eq(2)
  end
end
