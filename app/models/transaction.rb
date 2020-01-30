class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :merchants, through: :items

  scope :successful, -> { where(result: "success") }
end
