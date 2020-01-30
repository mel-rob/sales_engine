require 'rails_helper'

RSpec.describe 'invoice items API' do
  it 'can find a single invoice_item record by its id' do
    id_1 = create(:invoice_item).id
    id_2 = create(:invoice_item).id

    get "/api/v1/invoice_items/find?id=#{id_2}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to eq(id_2)
  end

  it 'can find a single invoice item by quantity' do
    invoice_item_1 = create(:invoice_item, quantity: 10)
    invoice_item_2 = create(:invoice_item, quantity: 5)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'can find a single invoice item by unit price' do
    invoice_item_1 = create(:invoice_item, unit_price: 12.45)
    invoice_item_2 = create(:invoice_item, unit_price: 23.12)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item_1.unit_price}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'can find a single invoice item by item id' do
    item_1 = create(:item)
    item_2 = create(:item)

    invoice_item_1 = create(:invoice_item, item_id: item_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_2.id)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item_1.item_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'can find a single invoice item by invoice id' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item_1.invoice_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'it can find a single invoice item based on created_at date' do
    invoice_item_1 = create(:invoice_item, created_at: "2020-01-29 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, created_at: "1938-05-13 12:53:59 UTC")

    get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    json_invoice_item = JSON.parse(response.body)['data']

    expect(json_invoice_item['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'it can find a single invoice item based on updated_at date' do
    invoice_item_1 = create(:invoice_item, created_at: "2020-01-29 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, created_at: "1938-05-13 12:53:59 UTC")

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

    expect(response).to be_successful

    json_invoice_item = JSON.parse(response.body)['data']

    expect(json_invoice_item['attributes']['id']).to eq(invoice_item_1.id)
  end

  it 'returns null when record does not exist' do

    get "/api/v1/invoice_items/find?id=5000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey

    get "/api/v1/invoice_items/find?quantity=1000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey

    get "/api/v1/invoice_items/find?unit_price=9000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey

    get "/api/v1/invoice_items/find?item_id=5000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey

    get "/api/v1/invoice_items/find?invoice_id=5000"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey

    get "/api/v1/invoice_items/find?created_at=10"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey

    get "/api/v1/invoice_items/find?updated_at=10"

    expect(response).to be_successful
    json_invoice_item = JSON.parse(response.body)
    expect(json_invoice_item['data']).to be_falsey
  end
end
