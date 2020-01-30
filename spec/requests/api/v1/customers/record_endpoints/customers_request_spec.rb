require 'rails_helper'

RSpec.describe 'Customers API' do
  it 'returns an index of all customer records' do
    create_list(:customer, 10)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']

    expect(customers.count).to eq(10)
  end

  it 'can get one customer by its id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(id)
  end
end
