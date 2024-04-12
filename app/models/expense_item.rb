class ExpenseItem < ApplicationRecord
  include AutomaticAccounting
  belongs_to :expense
end
