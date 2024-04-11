class AddDocumentTypeToExpenses < ActiveRecord::Migration[7.0]
  def up
    add_column :expenses,:document_type, :string
  end
  def down
    remove_column :expenses,:document_type
  end
end
