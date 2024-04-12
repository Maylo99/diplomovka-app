class BankStatementItem < ApplicationRecord
  include AutomaticAccounting
  belongs_to :bank_statement
end
