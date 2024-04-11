class BankStatementItem < ApplicationRecord
  belongs_to :bank_statement
  attribute :accounting_case
  attribute :accounting_case_side
  attribute :account_document_side
end
