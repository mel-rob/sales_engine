require 'rails_helper'

RSpec.describe 'single invoice customer request' do
  it 'shows customer for a specific invoice' do
    customer = create(:customer)

    invoice_1 = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice_1.id}/customer"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)['data']

    expect(json_customer['attributes']['id']).to eq(customer.id)
  end
end
