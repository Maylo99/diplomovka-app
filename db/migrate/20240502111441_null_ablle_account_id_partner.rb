class NullAblleAccountIdPartner < ActiveRecord::Migration[7.0]
  def change
    change_column_null :partners, :account_id, true
  end
end
