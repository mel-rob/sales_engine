require 'rails_helper'

RSpec.describe 'single invoice transactions request' do
  it 'shows all transactions for a specific invoice' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].length).to eq(2)
  end
end
