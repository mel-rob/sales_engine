require 'rails_helper'

RSpec.describe 'Invoices API' do
  it 'can find all invoice records by id' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find_all?id=#{invoice_1.id}"

    expect(response).to be_successful

    json_invoice = JSON.parse(response.body)['data']

    expect(json_invoice[0]['attributes']['id']).to eq(invoice_1.id)
  end

  it 'can find all invoice records by merchant id' do
    merchant = create(:merchant)

    invoice_1 = create(:invoice, merchant_id: merchant.id)
    invoice_2 = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/find_all?merchant_id=#{invoice_1.merchant_id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']

    expect(invoices.count).to eq(2)
    expect(invoices.first['attributes']['merchant_id']).to eq(invoice_1.merchant_id)
    expect(invoices.last['attributes']['merchant_id']).to eq(invoice_2.merchant_id)
  end

  it 'can find all invoice records by customer id' do
    customer = create(:customer)

    invoice_1 = create(:invoice, customer_id: customer.id)
    invoice_2 = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/find_all?customer_id=#{invoice_1.customer_id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']

    expect(invoices.count).to eq(2)
    expect(invoices.first['attributes']['customer_id']).to eq(invoice_1.customer_id)
    expect(invoices.last['attributes']['customer_id']).to eq(invoice_2.customer_id)
  end

  it 'can find all invoice records by status' do
    invoice_1 = create(:invoice, status: 'shipped')
    invoice_2 = create(:invoice, status: 'shipped')
    invoice_3 = create(:invoice, status: 'pending')

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']

    expect(invoices.count).to eq(2)
    expect(invoices.first['attributes']['status']).to eq(invoice_1.status)
    expect(invoices.last['attributes']['status']).to eq(invoice_2.status)
  end

  it 'is case insensitive for status' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    status_1 = invoice_1.status.upcase
    status_2 = invoice_2.status.upcase

    get "/api/v1/invoices/find_all?status=#{status_1}"

    expect(response).to be_successful

    json_invoices = JSON.parse(response.body)['data']

    expect(json_invoices.count).to eq(2)
    expect(json_invoices.first['attributes']['id']).to eq(invoice_1.id)
    expect(json_invoices.last['attributes']['id']).to eq(invoice_2.id)
  end

  it 'can find all invoice records by created_at date' do
    invoice_1 = create(:invoice, created_at: "2020-01-29 14:53:59 UTC")
    invoice_2 = create(:invoice, created_at: "2020-01-29 14:53:59 UTC")
    invoice_3 = create(:invoice, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']

    expect(invoices.count).to eq(2)
    expect(invoices.first['attributes']['id']).to eq(invoice_1.id)
    expect(invoices.last['attributes']['id']).to eq(invoice_2.id)
  end

  it 'can find all invoice records by updated_at date' do
    invoice_1 = create(:invoice, updated_at: "2020-01-29 14:53:59 UTC")
    invoice_2 = create(:invoice, updated_at: "2020-01-29 14:53:59 UTC")
    invoice_3 = create(:invoice, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/invoices/find_all?updated_at=#{invoice_1.updated_at}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']

    expect(invoices.count).to eq(2)
    expect(invoices.first['attributes']['id']).to eq(invoice_1.id)
    expect(invoices.last['attributes']['id']).to eq(invoice_2.id)
  end

  it 'returns empty when record does not exist' do

    get "/api/v1/invoices/find_all?id=1000"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_empty

    get "/api/v1/invoices/find_all?merchant_id=1000"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_empty

    get "/api/v1/invoices/find_all?customer_id=1000"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_empty

    get "/api/v1/invoices/find_all?status=1000"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_empty

    get "/api/v1/invoices/find_all?updated_at=10"

    expect(response).to be_successful
    json_invoice = JSON.parse(response.body)
    expect(json_invoice['data']).to be_empty
  end
end
