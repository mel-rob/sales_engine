class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.favorite_customer(id)
    select('customers.*, count(transactions.id) AS total_transactions')
    .joins(invoices: [transactions: :merchants])
    .group(:id)
    .where(invoices: {merchant_id: id})
    .merge(Transaction.successful)
    .order(total_transactions: :desc)
    .first
  end
end
