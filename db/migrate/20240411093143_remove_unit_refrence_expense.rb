class RemoveUnitRefrenceExpense < ActiveRecord::Migration[7.0]
  def up
    remove_reference :expenses, :unit
  end
end
