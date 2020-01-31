class Api::V1::Items::FindController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(find_params).order(:id))
  end

  def show
    render json: ItemSerializer.new(Item.find_by(find_params))
  end

private
  def find_params
    params.permit(:id, :name, :description, :unit_price, :updated_at, :created_at, :merchant_id)
  end
end
