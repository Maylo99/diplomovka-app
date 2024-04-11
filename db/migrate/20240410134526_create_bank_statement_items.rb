class CreateBankStatementItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_statement_items do |t|
      t.string :description
      t.date :settlement_date
      t.decimal :amount
      t.references :bank_statement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
