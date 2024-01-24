class ExpensesController < ApplicationController
  include Params::AddressParams
  include Params::InvoiceAccountParams
  before_action :set_account
  before_action :set_expense, only: %i[ show edit update destroy ]

  # GET /expenses or /expenses.json
  def index
    @expenses = @account.expenses
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    # @expense_item = @expense.expense_items.build
    @unit_address = Address.new
    @invoice_account = InvoiceAccount.new
    @address = Address.new
  end

  # GET /expenses/1/edit
  def edit
    @unit_address = @expense.unit
    @invoice_account = @expense.invoice_account
    @address = @invoice_account.invoice_address
  end

  # POST /expenses or /expenses.json
  def create
    ActiveRecord::Base.transaction do
      begin
        @unit_address = Address.find_or_create_by(address_params(:unit)) if params[:unit]
        @address = Address.find_or_create_by(address_params(:address))
        @invoice_account = InvoiceAccount.find_or_create_by(invoice_account_params(:invoice_account).merge({ :invoice_address_id => @address.id,
                                                                                                             :postal_address_id => @postal_address&.id
                                                                                                           }))
        @expense = Expense.new(expense_params.merge({ :unit_id => @unit_address.id,
                                                          :invoice_account_id => @invoice_account.id,
                                                          :account_id => @account.id }))
        @expense.save!
      rescue ActiveRecord::RecordInvalid
        @unit_address.validate
        @address.validate
        @invoice_account.validate
        @expense.validate
      end
    end

    respond_to do |format|
      if @expense.persisted?
        format.html { redirect_to expense_url(@account, @expense), notice: "Expense was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    ActiveRecord::Base.transaction do
      begin
        @is_updated=true
        @unit_address = Address.find_or_create_by(address_params(:unit)) if params[:unit]
        @address =Address.find_or_create_by(address_params(:address))
        @invoice_account = InvoiceAccount.find_or_create_by(invoice_account_params(:invoice_account).merge({ :invoice_address_id => @address.id,
                                                                                                             :postal_address_id => @postal_address&.id
                                                                                                           }))
        @expense=Expense.find(params[:id])
        @expense.update!(expense_params.merge({ :unit_id => @unit_address.id,
                                                 :invoice_account_id => @invoice_account.id,
                                                 :account_id => @account.id }))
      rescue ActiveRecord::RecordInvalid
        @is_updated=false
        @unit_address.validate
        @address.validate
        @invoice_account.validate
        @expense.validate
      end
    end

    respond_to do |format|
      if @is_updated
        format.html { redirect_to expense_url(@account, @expense), notice: "Expense was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:receipt_id, :cash_register_code, :issue_date, :okp, :receipt_number)
  end
end
