class Address < ApplicationRecord
  has_many :invoice_accounts, :foreign_key => "invoice_address_id", class_name: 'InvoiceAccount'
  has_many :invoice_accounts, :foreign_key => "postal_address_id", class_name: 'InvoiceAccount'
  has_many :expenses, :foreign_key => "unit_id", class_name: 'Expense'
  validates :name, presence: true

end
