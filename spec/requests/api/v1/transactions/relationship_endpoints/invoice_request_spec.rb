require 'rails_helper'

RSpec.describe 'single transaction invoice request' do
  it 'shows invoice for a specific transaction' do
    invoice = create(:invoice)

    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    json_invoice = JSON.parse(response.body)['data']

    expect(json_invoice['attributes']['id']).to eq(invoice.id)
  end
end
