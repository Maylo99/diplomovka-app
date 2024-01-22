class CreateInvoiceAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_accounts do |t|
      t.string :vat_payer_type
      t.string :registration_id, limit: 100
      t.string :tax_id, limit: 100
      t.string :vat_id,limit: 100
      t.string :phone_number, limit: 20
      t.string :email
      t.string :web

      t.timestamps
    end
  end
end
