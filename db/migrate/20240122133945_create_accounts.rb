class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :accounting_type
      t.string :register_text
      t.string :country
      t.string :legal_form

      t.timestamps
    end
  end
end
