require 'rails_helper'

RSpec.describe 'Invoices API' do
  it 'can find a single invoice record by its id' do
    id_1 = create(:invoice).id
    id_2 = create(:invoice).id
    id_3 = create(:invoice).id

    get "/api/v1/invoices/find?id=#{id_2}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['id']).to eq(id_2)
  end

  it 'can find a single invoice by merchant_id' do
    merchant_id = create(:invoice).merchant_id

    get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['merchant_id']).to eq(merchant_id)
  end

  it 'can find a single invoice by customer_id' do
    customer_id = create(:invoice).customer_id

    get "/api/v1/invoices/find?customer_id=#{customer_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['customer_id']).to eq(customer_id)
  end

  it 'can find a single invoice by status' do
    status = create(:invoice).status

    get "/api/v1/invoices/find?status=#{status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['status']).to eq(status)
  end

  xit 'is case insensitive for status' do
    invoice = create(:invoice)
    status = invoice.status.downcase

    get "/api/v1/invoices/find?status=#{status}"

    expect(response).to be_successful

    json_invoice = JSON.parse(response.body)['data']

    expect(json_invoice['attributes']['status']).to eq(status)
  end

  it 'it can find a single invoice based on created_at date' do
    invoice = create(:invoice, created_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    expect(response).to be_successful

    json_invoice = JSON.parse(response.body)['data']

    expect(json_invoice['attributes']['id']).to eq(invoice.id)
  end

  it 'it can find a single invoice based on updated_at date' do
    invoice = create(:invoice, updated_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    expect(response).to be_successful

    json_invoice = JSON.parse(response.body)['data']

    expect(json_invoice['attributes']['id']).to eq(invoice.id)
  end

  it 'returns null when record does not exist' do

    get "/api/v1/invoices/find?id=101"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey

    get "/api/v1/invoices/find?customer_id=1000"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey

    get "/api/v1/invoices/find?merchant_id=1000"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey

    get "/api/v1/invoices/find?name=test"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey

    get "/api/v1/invoices/find?status=test"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey

    get "/api/v1/invoices/find?created_at=10"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey

    get "/api/v1/invoices/find?updated_at=10"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_falsey
  end
end
