class CreateExpenseItems < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_items do |t|
      t.string :name
      t.decimal :quantity
      t.decimal :vat_rate
      t.decimal :unit_price
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
