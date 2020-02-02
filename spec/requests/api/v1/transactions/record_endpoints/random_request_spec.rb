require 'rails_helper'

describe "Transactions random request" do
  it 'returns a random transaction' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/random"

    expect(response).to be_successful

    json_transaction = JSON.parse(response.body)
    expect(json_transaction['data']['attributes']['id']).to eq(transaction_1.id).or eq(transaction_2.id)
  end
end
