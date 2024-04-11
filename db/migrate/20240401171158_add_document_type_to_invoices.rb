class AddDocumentTypeToInvoices < ActiveRecord::Migration[7.0]
  def up
    add_column :invoices, :document_type, :string
  end

  def down
    remove_column :invoices,:document_type
  end
end
