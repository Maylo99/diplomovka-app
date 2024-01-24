class CreateInvoiceBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_bank_accounts do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :bank_account, null: false, foreign_key: true
    end
  end
end
