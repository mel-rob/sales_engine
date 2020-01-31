require 'rails_helper'

RSpec.describe 'Items API' do
  it 'returns an index of all item records' do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']

    expect(items.count).to eq(10)
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(id)
  end
end
