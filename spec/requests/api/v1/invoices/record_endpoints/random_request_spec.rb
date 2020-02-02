require 'rails_helper'

describe "Invoices random request" do
  it 'returns a random invoice' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/random"

    expect(response).to be_successful

    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']['attributes']['id']).to eq(invoice_1.id).or eq(invoice_2.id)
  end
end
