require 'rails_helper'

describe "Item random request" do
  it 'returns a random item' do
    item_1 = create(:item)
    item_2 = create(:item)

    get "/api/v1/items/random"

    expect(response).to be_successful

    json_item = JSON.parse(response.body)
    expect(json_item['data']['attributes']['id']).to eq(item_1.id).or eq(item_2.id)
  end
end
