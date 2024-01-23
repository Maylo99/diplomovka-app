class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.date :issue_date
      t.date :delivery_date
      t.date :due_date
      t.string :number
      t.string :payment_method
      t.string :variable_symbol
      t.string :order_number
      t.references :purchaser, index: true, foreign_key:{to_table: :invoice_accounts}
      t.references :supplier, index: true, foreign_key:{to_table: :invoice_accounts}
      t.references :account, index: true, foreign_key:{to_table: :accounts}

      t.timestamps
    end
  end
end
