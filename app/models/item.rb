require_relative 'modules/dollarable'

class Item < ApplicationRecord
  include Dollarable

  before_validation :change_to_dollars
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.most_revenue(limit)
    joins(invoice_items: :transactions)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .merge(Transaction.successful)
    .order(revenue: :desc)
    .limit(limit)
  end
end
