class InvoiceAccount < ApplicationRecord
  has_many :accounts
  has_many :partners
  has_many :purchaser, foreign_key: 'supplier_id', class_name: 'Invoice'
  has_many :supplier, foreign_key: 'purchaser_id', class_name: 'Invoice'
  belongs_to :invoice_address, foreign_key: 'invoice_address_id', class_name: 'Address'
  belongs_to :postal_address, foreign_key: 'postal_address_id', class_name: 'Address', optional: true
  enum vat_payer_type: { standard: 'Platca DPH', foreign: 'Platca DPH podľa §7', non_payer_vat: "Neplatca DPH" }
end
