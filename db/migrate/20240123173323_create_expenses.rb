class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :receipt_id
      t.string :cash_register_code
      t.datetime :issue_date
      t.string :okp
      t.string :receipt_number
      t.string :country
      t.references :account, null: false, foreign_key: true
      t.references :invoice_account, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: {to_table: :addresses}

      t.timestamps
    end
  end
end
