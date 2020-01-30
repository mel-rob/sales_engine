require 'rails_helper'

RSpec.describe 'single invoice merchant request' do
  it 'shows merchant for a specific invoice' do
    merchant = create(:merchant)

    invoice_1 = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice_1.id}/merchant"

    expect(response).to be_successful

    json_merchant = JSON.parse(response.body)['data']

    expect(json_merchant['attributes']['id']).to eq(merchant.id)
  end
end
