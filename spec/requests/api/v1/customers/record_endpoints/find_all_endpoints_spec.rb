require 'rails_helper'

RSpec.describe 'Customers API' do
  it 'can find all customer records by id' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer_1.id}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)['data']

    expect(json_customer[0]['attributes']['id']).to eq(customer_1.id)
  end

  it 'can find all customer records by first name' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']

    expect(customers.count).to eq(2)
    expect(customers.first['attributes']['first_name']).to eq(customer_1.first_name)
    expect(customers.last['attributes']['first_name']).to eq(customer_2.first_name)
  end

  it 'can find all customer records by last name' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']

    expect(customers.count).to eq(2)
    expect(customers.first['attributes']['last_name']).to eq(customer_1.last_name)
    expect(customers.last['attributes']['last_name']).to eq(customer_2.last_name)
  end

  xit 'is case insensitive for name' do
    customer = create(:customer)
    name = customer.name.downcase

    get "/api/v1/customers/find_all?name=#{name}"

    expect(response).to be_successful

    json_customer = JSON.parse(response.body)['data']

    expect(json_customer['attributes']['name']).to eq(name)
  end

  it 'can find all customer records by created_at date' do
    customer_1 = create(:customer, created_at: "2020-01-29 14:53:59 UTC")
    customer_2 = create(:customer, created_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']

    expect(customers.count).to eq(2)
    expect(customers.first['attributes']['id']).to eq(customer_1.id)
    expect(customers.last['attributes']['id']).to eq(customer_2.id)
  end

  it 'can find all customer records by updated_at date' do
    customer_1 = create(:customer, updated_at: "2020-01-29 14:53:59 UTC")
    customer_2 = create(:customer, updated_at: "2020-01-29 14:53:59 UTC")

    get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']

    expect(customers.count).to eq(2)
    expect(customers.first['attributes']['id']).to eq(customer_1.id)
    expect(customers.last['attributes']['id']).to eq(customer_2.id)
  end

  it 'returns empty when record does not exist' do

    get "/api/v1/customers/find_all?id=101"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_empty

    get "/api/v1/customers/find_all?first_name=test"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_empty

    get "/api/v1/customers/find_all?last_name=test"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_empty

    get "/api/v1/customers/find_all?created_at=10"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_empty

    get "/api/v1/customers/find_all?updated_at=10"

    expect(response).to be_successful
    json_customer = JSON.parse(response.body)
    expect(json_customer['data']).to be_empty
  end
end
