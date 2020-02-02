class Api::V1::Merchants::CustomersController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.favorite_customer(params[:id]))
  end
end
