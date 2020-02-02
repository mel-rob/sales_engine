require 'rails_helper'

describe "Invoice Item random request" do
  it 'returns a random invoice item' do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/random"

    expect(response).to be_successful

    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']['attributes']['id']).to eq(invoice_item_1.id).or eq(invoice_item_2.id)
  end
end
