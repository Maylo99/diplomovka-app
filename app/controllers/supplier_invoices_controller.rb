# frozen_string_literal: true

class SupplierInvoicesController <InvoicesController

  def invoice_type
    "dfa"
  end

  def index_path
    supplier_invoices_path(@account)
  end

  def new_path
    new_supplier_invoice_path(@account)
  end

  def edit_path
    edit_supplier_invoice_path(@account,@invoice)
  end

  def update_url
    sales_supplier_path(@account,@invoice)
  end
end
