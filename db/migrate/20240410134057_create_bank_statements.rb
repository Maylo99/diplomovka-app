class CreateBankStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_statements do |t|
      t.references :account, null: false, foreign_key: true
      t.references :bank_account, null: false, foreign_key: true
      t.string :number
      t.string :serial_number
      t.string :accounting_period_month
      t.string :accounting_period_year
      t.date :delivery_date
      t.date :date_of_issue

      t.timestamps
    end
  end
end
