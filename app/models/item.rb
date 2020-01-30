require_relative 'modules/dollarable'

class Item < ApplicationRecord
  include Dollarable

  before_validation :change_to_dollars
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
