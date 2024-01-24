class InvoiceBankAccount < ApplicationRecord
  belongs_to :invoice
  belongs_to :bank_account
end
