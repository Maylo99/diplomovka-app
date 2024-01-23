class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.string :name, limit: 100
      t.string :currency, limit: 10, null: false
      t.string :iban, limit: 50, null: false
      t.string :swift_code,limit: 15, null: false
      t.string :account_number, null: false
      t.string :bank_code, limit: 10
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
