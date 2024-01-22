class AddReferencesToUserAccounts < ActiveRecord::Migration[7.0]
  def up
    add_reference :user_accounts, :user, foreign_keys: true
    add_reference :user_accounts, :account, foreign_keys: true
    add_index :user_accounts, [:account_id, :user_id], unique: true
  end

  def down
    remove_reference :user_accounts, :user, foreign_keys: true
    remove_reference :user_accounts, :account, foreign_keys: true
    remove_index :user_accounts, [:account_id, :user_id], unique: true
  end
end
