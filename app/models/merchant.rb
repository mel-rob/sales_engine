class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :items

  def self.most_revenue(limit)
    joins(invoice_items: :transactions)
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .merge(Transaction.successful)
    .order(revenue: :desc)
    .limit(limit)
  end
end
