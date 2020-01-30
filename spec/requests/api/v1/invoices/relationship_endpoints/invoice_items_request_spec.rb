require 'rails_helper'

RSpec.describe 'single invoice invoice items request' do
  it 'shows all invoice items for a specific invoice' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id)

    get "/api/v1/invoices/#{invoice_1.id}/invoice_items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].length).to eq(2)
  end
end
