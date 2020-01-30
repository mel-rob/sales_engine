class Api::V1::Merchants::FindController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.where(find_params).order(:id))
  end

  def show
    render json: MerchantSerializer.new(Merchant.find_by(find_params))
  end

private
  def find_params
    params.permit(:id, :name, :updated_at, :created_at)
  end
end
