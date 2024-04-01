class InvoiceItem < ApplicationRecord
  attribute :testik
  attribute :strana
  belongs_to :invoice
end
