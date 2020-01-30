require 'rails_helper'

RSpec.describe 'InvoiceItems API' do
  it 'returns an index of all invoice item records' do
    create_list(:invoice_item, 10)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(10)
  end

  it 'can get one invoice by its id' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to eq(id)
  end
end
