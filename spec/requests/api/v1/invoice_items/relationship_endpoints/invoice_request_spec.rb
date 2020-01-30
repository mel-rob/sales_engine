require 'rails_helper'

RSpec.describe 'single invoice item invoice request' do
  it 'shows invoice for a specific invoice item' do
    invoice = create(:invoice)

    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(invoice.id)
  end
end
