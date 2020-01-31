class Api::V1::Transactions::FindController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.where(find_params).order(:id))
  end

  def show
    render json: TransactionSerializer.new(Transaction.find_by(find_params))
  end

private
  def find_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :updated_at, :created_at, :invoice_id)
  end
end
