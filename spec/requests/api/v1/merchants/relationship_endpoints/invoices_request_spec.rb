require 'rails_helper'

RSpec.describe 'single merchant invoices page' do
  it 'shows all invoices for a specific merchant' do
    merchant = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)

    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
    invoice_3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].length).to eq(3)
  end
end
