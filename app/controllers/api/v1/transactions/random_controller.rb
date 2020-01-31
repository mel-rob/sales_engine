class Api::V1::Transaction::RandomController < ApplicationController

  def show
    render json: TransactionSerializer.new(Transaction.random)
  end
end
