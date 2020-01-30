class Api::V1::Invoices::FindController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(find_params).order(:id))
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(find_params))
  end

private
  def find_params
    params.permit(:id, :customer_id, :merchant_id, :status, :updated_at, :created_at)
  end
end
