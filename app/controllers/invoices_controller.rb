class InvoicesController < ApplicationController
  include Documentable
  include Params::AddressParams
  include Params::InvoiceAccountParams
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.where(account_id: @account, document_type: invoice_type)
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new(document_type: invoice_type)
    @invoice.number = set_document_number(params[:account_id])
    # @invoice.document_items.build
  end

  # GET /invoices/1/edit
  def edit
    @invoice_account = @invoice.purchaser
    @address = @invoice_account.invoice_address
    @postal_address = @invoice_account.postal_address.nil? ? Address.new : @invoice_account.postal_address

    @supplier_invoice_account = @invoice.supplier
    @supplier_address = @supplier_invoice_account.invoice_address
  end

  # POST /invoices or /invoices.json
  def create
    client_id = params[:invoice][:client]
    @invoice_account = InvoiceAccount.find(client_id) if client_id.present?
    ActiveRecord::Base.transaction do
      begin
        @invoice = Invoice.new(invoice_params.merge(document_type: invoice_type))
        @invoice.supplier_id = @account.invoice_account.id
        @invoice.account = @account
        @invoice.purchaser_id = @invoice_account&.id
        unless @invoice.save
          raise ActiveRecord::RecordInvalid
        end
        InvoiceBankAccount.create(bank_account_id: params[:invoice][:bank_account_id], invoice_id: @invoice.id)

      rescue ActiveRecord::RecordInvalid
        @invoice.validate
      end
    end

    respond_to do |format|
      if @invoice.persisted?
        format.html { redirect_to edit_path, notice: "Invoice was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params.merge(document_type: invoice_type, purchaser_id: params[:invoice][:client]))
        @invoice.invoice_bank_accounts.first.update(bank_account_id: params[:invoice][:bank_account_id])
        format.html { redirect_to edit_path, notice: "Invoice was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    if @invoice.destroy
      respond_to do |format|
        format.html { redirect_to index_path, notice: "Invoice was successfully destroyed." }
      end
    end
  end

  protected

  def invoice_type
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def new_path
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def edit_path
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def update_url
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def index_path
    raise NotImplementedError, "Subclasses must implement this method"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:document_type, :issue_date, :delivery_date, :due_date, :number, :payment_method, :variable_symbol, :order_number,
                                    invoice_items_attributes: [:id, :name, :description, :quantity, :measure_unit, :unit_price, :vat_rate, :_destroy])
  end
end
