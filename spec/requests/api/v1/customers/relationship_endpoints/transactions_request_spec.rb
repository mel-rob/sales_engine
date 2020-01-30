require 'rails_helper'

RSpec.describe 'single customer transactions page' do
  it 'shows all transactions for a specific customer' do

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/customers/#{customer_1.id}/transactions"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].length).to eq(2)
  end
end
