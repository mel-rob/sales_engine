require 'rails_helper'

RSpec.describe 'Invoices API' do
  it 'returns an index of all invoice records' do
    create_list(:invoice, 10)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']

    expect(invoices.count).to eq(10)
  end

  it 'can get one invoice by its id' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['id']).to eq(id)
  end
end
