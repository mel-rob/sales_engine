require 'rails_helper'

describe "Customers random request" do
  it 'returns a random customer' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/random"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)
    expect(json_customer['data']['attributes']['id']).to eq(customer_1.id).or eq(customer_2.id)
  end
end
