class NullAblleAccountIdBankAccount < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bank_accounts, :account_id, true
  end
end
