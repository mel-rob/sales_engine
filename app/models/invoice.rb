class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.revenue(date)
    total_revenue = joins(transactions: :invoice_items)
    .select('sum(invoice_items.quantity * invoice_items.unit_price) AS date_revenue')
    .where(created_at: date.to_date.all_day)
    .merge(Transaction.successful)
    total_revenue[0]
  end
end
