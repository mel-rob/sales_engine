require 'rails_helper'

RSpec.describe 'Customers API' do
  it 'can find a single customer record by its id' do
    id_1 = create(:customer).id
    id_2 = create(:customer).id
    id_3 = create(:customer).id

    get "/api/v1/customers/find?id=#{id_2}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(id_2)
  end

  it 'can find a single customer by its first name' do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['first_name']).to eq(first_name)
  end

  it 'can find a single customer by its last name' do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['last_name']).to eq(last_name)
  end

  xit 'is case insensitive for name' do
    customer = create(:customer)
    name = customer.name.downcase

    get "/api/v1/customers/find?name=#{name}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)['data']

    expect(json_customer['attributes']['name']).to eq(name)
  end

  it 'it can find a single customer based on created_at date' do
    customer = create(:customer, created_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)['data']

    expect(json_customer['attributes']['id']).to eq(customer.id)
  end

  it 'it can find a single customer based on updated_at date' do
    customer = create(:customer, updated_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)['data']

    expect(json_customer['attributes']['id']).to eq(customer.id)
  end

  it 'returns null when record does not exist' do

    get "/api/v1/customers/find?id=101"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_falsey

    get "/api/v1/customers/find?name=test"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_falsey

    get "/api/v1/customers/find?created_at=10"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_falsey

    get "/api/v1/customers/find?updated_at=10"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_falsey
  end
end
