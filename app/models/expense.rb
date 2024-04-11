class Expense < ApplicationRecord
  belongs_to :account
  belongs_to :invoice_account
  has_many :expense_items
  accepts_nested_attributes_for :expense_items, allow_destroy: true
  enum country: {sk: 'Slovensko'}
  validates :okp, presence: true
end
