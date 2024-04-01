# frozen_string_literal: true

class SalesInvoicesController < InvoicesController
  def invoice_type
    "ofa"
  end
  def index_path
    sales_invoices_path(@account)
  end
  def new_path
    new_sales_invoice_path(@account)
  end

  def edit_path
    edit_sales_invoice_path(@account,@invoice)
  end

  def update_url
    sales_invoice_path(@account,@invoice)
  end
end
