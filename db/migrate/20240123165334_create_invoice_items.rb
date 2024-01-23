class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.string :name
      t.decimal :quantity
      t.string :measure_unit
      t.decimal :unit_price
      t.decimal :vat_rate
      t.references :invoice, index: true, foreign_key: true


      t.timestamps
    end
  end
end
