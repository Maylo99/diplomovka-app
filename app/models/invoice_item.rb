class InvoiceItem < ApplicationRecord
  include AutomaticAccounting
  belongs_to :invoice
end
