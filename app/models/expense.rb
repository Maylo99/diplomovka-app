class Expense < ApplicationRecord
  belongs_to :account
  belongs_to :invoice_account
  belongs_to :unit, foreign_key: "unit_id", class_name: "Address"
  # has_many :expense_items
  enum country: {sk: 'Slovensko'}
  validates :okp, presence: true
end
