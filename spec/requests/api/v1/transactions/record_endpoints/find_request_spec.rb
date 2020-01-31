require 'rails_helper'

RSpec.describe 'Transactions API' do
  it 'can find a single transaction record by its id' do
    id_1 = create(:transaction).id
    id_2 = create(:transaction).id
    id_3 = create(:transaction).id

    get "/api/v1/transactions/find?id=#{id_2}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes']['id']).to eq(id_2)
  end

  it 'can find a single transaction by credit_card_number' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction['attributes']['id']).to eq(transaction.id)
  end

  it 'can find a single transaction by credit_card_expiration_date' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{transaction.credit_card_expiration_date}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction['attributes']['id']).to eq(transaction.id)
  end

  it 'can find a single transaction by result' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?status=#{transaction.result}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction['attributes']['id']).to eq(transaction.id)
  end

  xit 'is case insensitive for result' do
    transaction = create(:transaction)
    result = transaction.result.downcase

    get "/api/v1/transactions/find?result=#{result}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction['attributes']['id']).to eq(transaction.id)
  end

  it 'can find a single transaction by invoice_id' do
    invoice_id = create(:transaction).invoice_id

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes']['invoice_id']).to eq(invoice_id)
  end

  it 'it can find a single transaction based on created_at date' do
    transaction_1 = create(:transaction, created_at: "2020-01-29 14:53:59 UTC")
    transaction_2 = create(:transaction, created_at: "1938-04-19 14:53:59 UTC")

    get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction['attributes']['id']).to eq(transaction_1.id)
  end

  it 'it can find a single transaction based on updated_at date' do
    transaction_1 = create(:transaction, updated_at: "2020-01-29 14:53:59 UTC")
    transaction_2 = create(:transaction, updated_at: "1938-04-19 14:53:59 UTC")

    get "/api/v1/transactions/find?updated_at=#{transaction_1.updated_at}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction['attributes']['id']).to eq(transaction_1.id)
  end

  it 'returns null when record does not exist' do

    get "/api/v1/transactions/find?id=101"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey

    get "/api/v1/transactions/find?credit_card_number=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey

    get "/api/v1/transactions/find?credit_card_expiration_date=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey

    get "/api/v1/transactions/find?result=test"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey

    get "/api/v1/transactions/find?invoice_id=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey

    get "/api/v1/transactions/find?created_at=10"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey

    get "/api/v1/transactions/find?updated_at=10"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_falsey
  end
end
