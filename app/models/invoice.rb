class Invoice < ApplicationRecord
  attribute :account_number
  belongs_to :supplier, foreign_key: 'supplier_id', class_name: "InvoiceAccount"
  belongs_to :purchaser, foreign_key: 'purchaser_id', class_name: "InvoiceAccount"
  belongs_to :account, optional: true
  has_many :invoice_bank_accounts, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  accepts_nested_attributes_for :invoice_items, allow_destroy: true
  validates :number, presence: true
  validates :order_number, presence: true
  enum payment_method: { bank: "Bankový prevod", cash: "Hotovosť", cash_on_delivery: "Dobierka" }
  enum account_number: { dfa: "321", ofa: "311" }


  def self.my_last_invoice_in_year(account_id, year)
    where('extract(year  from created_at) = ? and account_id=?', year, account_id).order('created_at DESC').first
  end
end
