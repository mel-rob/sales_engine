require 'rails_helper'

RSpec.describe 'Transactions API' do
  it 'returns an index of all transaction records' do
    create_list(:transaction, 10)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']

    expect(transactions.count).to eq(10)
  end

  it 'can get one transaction by its id' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes']['id']).to eq(id)
  end
end
