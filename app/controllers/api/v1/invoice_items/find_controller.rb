class Api::V1::InvoiceItems::FindController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(find_params).order(:id))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(find_params))
  end

private
  def find_params
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :updated_at, :created_at)
  end
end
