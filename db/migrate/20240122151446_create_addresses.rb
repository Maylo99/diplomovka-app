class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :register_number, limit: 30
      t.string :contact, limit: 100
      t.string :street
      t.string :city
      t.string :postal_code, limit: 10
      t.string :street_number
      t.string :country

      t.timestamps
    end
  end
end
