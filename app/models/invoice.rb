class Invoice < ApplicationRecord
  belongs_to :supplier, foreign_key: 'supplier_id', class_name: "InvoiceAccount"
  belongs_to :purchaser, foreign_key: 'purchaser_id', class_name: "InvoiceAccount"
  belongs_to :account, optional: true

  enum payment_method: { bank: "Bankový prevod", cash: "Hotovosť", cash_on_delivery: "Dobierka" }

  def self.my_last_invoice_in_year(account_id, year)
    where('extract(year  from created_at) = ? and account_id=?', year, account_id).order('created_at DESC').first
  end
end
