class CreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners do |t|
      t.references :account, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: { to_table: :invoice_accounts }
      t.string :name, null: false
    end
  end
end
