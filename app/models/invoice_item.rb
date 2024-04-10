class InvoiceItem < ApplicationRecord
  attribute :accounting_case
  attribute :accounting_case_side
  attribute :account_dph_side
  attribute :account_invoice_side
  belongs_to :invoice
end
