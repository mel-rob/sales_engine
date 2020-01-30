require_relative 'modules/dollarable'

class InvoiceItem < ApplicationRecord
  include Dollarable

  before_validation :change_to_dollars
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice
end
