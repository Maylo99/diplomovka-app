class AddReferences < ActiveRecord::Migration[7.0]
  def up
    add_reference :accounts, :invoice_account, foreign_key: true
    add_reference :invoice_accounts, :invoice_address,foreign_key: { to_table: :addresses }
    add_reference :invoice_accounts, :postal_address, foreign_key: { to_table: :addresses }
  end

  def down
    remove_reference :accounts, :invoice_account
    remove_reference :invoice_accounts, :invoice_address
    remove_reference :invoice_accounts, :postal_address
  end
end
