require 'rails_helper'

RSpec.describe 'invoice items API' do
  it 'can find all invoice item records by id' do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

    expect(response).to be_successful

    json_invoice_item = JSON.parse(response.body)['data']

    expect(json_invoice_item[0]['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'can find all invoice item records by quantity' do
    invoice_item_1 = create(:invoice_item, quantity: 10)
    invoice_item_2 = create(:invoice_item, quantity: 10)
    invoice_item_3 = create(:invoice_item, quantity: 20)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items.last['attributes']['id']).to eq(invoice_item_2.id)
  end

  it 'can find all invoice item records by unit price' do
    invoice_item_1 = create(:invoice_item, unit_price: 10.37)
    invoice_item_2 = create(:invoice_item, unit_price: 10.37)
    invoice_item_3 = create(:invoice_item, unit_price: 20.21)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_1.unit_price}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items.last['attributes']['id']).to eq(invoice_item_2.id)
  end

  it 'can find all invoice item records by item id' do
    item_1 = create(:item)
    item_2 = create(:item)

    invoice_item_1 = create(:invoice_item, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id)
    invoice_item_3 = create(:invoice_item, item_id: item_2.id)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item_1.item_id}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items.last['attributes']['id']).to eq(invoice_item_2.id)
  end

  it 'can find all invoice item records by invoice id' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items.last['attributes']['id']).to eq(invoice_item_2.id)
  end

  it 'can find all invoice item records by created_at date' do
    invoice_item_1 = create(:invoice_item, created_at: "2020-01-29 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, created_at: "2020-01-29 14:53:59 UTC")
    invoice_item_3 = create(:invoice_item, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items.last['attributes']['id']).to eq(invoice_item_2.id)
  end

  it 'can find all invoice item records by updated_at date' do
    invoice_item_1 = create(:invoice_item, updated_at: "2020-01-29 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, updated_at: "2020-01-29 14:53:59 UTC")
    invoice_item_3 = create(:invoice_item, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item_1.updated_at}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']

    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items.last['attributes']['id']).to eq(invoice_item_2.id)
  end

  it 'returns empty when record does not exist' do

    get "/api/v1/invoice_items/find_all?id=9000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty

    get "/api/v1/invoice_items/find_all?quantity=9000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty

    get "/api/v1/invoice_items/find_all?unit_price=10000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty

    get "/api/v1/invoice_items/find_all?invoice_id=10000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty

    get "/api/v1/invoice_items/find_all?item_id=10000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty

    get "/api/v1/invoice_items/find_all?created_at=10"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty

    get "/api/v1/invoice_items/find_all?updated_at=10"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_empty
  end
end
