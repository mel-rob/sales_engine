require 'rails_helper'

RSpec.describe 'Transactions API' do
  it 'can find all transaction records by id' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find_all?id=#{transaction_1.id}"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)['data']

    expect(json_transaction[0]['attributes']['id']).to eq(transaction_1.id)
  end

  it 'can find all transaction records by credit card number' do
    transaction_1 = create(:transaction, credit_card_number: '12345')
    transaction_2 = create(:transaction, credit_card_number: '12345')
    transaction_3 = create(:transaction, credit_card_number: '67890')

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(2)
    expect(transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(transactions.last['attributes']['id']).to eq(transaction_2.id)
  end

  it 'can find all transaction records by credit card expiration date' do
    transaction_1 = create(:transaction, credit_card_expiration_date: '12345')
    transaction_2 = create(:transaction, credit_card_expiration_date: '12345')
    transaction_3 = create(:transaction, credit_card_expiration_date: '67890')

    get "/api/v1/transactions/find_all?credit_card_expiration_date=#{transaction_1.credit_card_expiration_date}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(2)
    expect(transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(transactions.last['attributes']['id']).to eq(transaction_2.id)
  end

  it 'can find all transaction records by result' do
    transaction_1 = create(:transaction, result: 'success')
    transaction_2 = create(:transaction, result: 'success')
    transaction_3 = create(:transaction, result: 'failure')

    get "/api/v1/transactions/find_all?result=#{transaction_1.result}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(2)
    expect(transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(transactions.last['attributes']['id']).to eq(transaction_2.id)
  end

  it 'is case insensitive for result' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    result_1 = transaction_1.result.upcase
    result_2 = transaction_2.result.upcase

    get "/api/v1/transactions/find_all?result=#{result_1}"

    expect(response).to be_successful

    json_transactions = JSON.parse(response.body)['data']

    expect(json_transactions.count).to eq(2)
    expect(json_transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(json_transactions.last['attributes']['id']).to eq(transaction_2.id)
  end

  it 'can find all transaction records by invoice id' do
    invoice = create(:invoice)

    transaction_1 = create(:transaction, invoice_id: invoice.id)
    transaction_2 = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction_1.invoice_id}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(2)
    expect(transactions.first['attributes']['invoice_id']).to eq(transaction_1.invoice_id)
    expect(transactions.last['attributes']['invoice_id']).to eq(transaction_2.invoice_id)
  end

  it 'can find all transaction records by created_at date' do
    transaction_1 = create(:transaction, created_at: "2020-01-29 14:53:59 UTC")
    transaction_2 = create(:transaction, created_at: "2020-01-29 14:53:59 UTC")
    transaction_3 = create(:transaction, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(2)
    expect(transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(transactions.last['attributes']['id']).to eq(transaction_2.id)
  end

  it 'can find all transaction records by updated_at date' do
    transaction_1 = create(:transaction, updated_at: "2020-01-29 14:53:59 UTC")
    transaction_2 = create(:transaction, updated_at: "2020-01-29 14:53:59 UTC")
    transaction_3 = create(:transaction, created_at: "2019-05-26 13:563:59 UTC")

    get "/api/v1/transactions/find_all?updated_at=#{transaction_1.updated_at}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(2)
    expect(transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(transactions.last['attributes']['id']).to eq(transaction_2.id)
  end

  it 'returns empty when record does not exist' do

    get "/api/v1/transactions/find_all?id=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty

    get "/api/v1/transactions/find_all?credit_card_number=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty

    get "/api/v1/transactions/find_all?credit_card_expiration_date=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty

    get "/api/v1/transactions/find_all?result=failure"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty

    get "/api/v1/transactions/find_all?invoice_id=1000"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty

    get "/api/v1/transactions/find_all?created_at=10"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty

    get "/api/v1/transactions/find_all?updated_at=10"

    expect(response).to be_successful
    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']).to be_empty
  end
end
