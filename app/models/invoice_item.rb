class InvoiceItem < ApplicationRecord
  attribute :accounting_case_select
  attribute :accounting_case_input
  attribute :accounting_case_side
  attribute :account_dph_side
  attribute :account_document_side
  attribute :account_document
  attribute :account_dph
  belongs_to :invoice
end
