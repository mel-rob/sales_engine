require 'rails_helper'

RSpec.describe 'application record methods' do

  it '.random' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    expect(Merchant.random).to eq(merchant_1).or eq(merchant_2)
  end
end
