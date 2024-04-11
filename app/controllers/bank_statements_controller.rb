class BankStatementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_bank_statement, only: %i[  edit update destroy ]

  # GET /bank_statements or /bank_statements.json
  def index
    @bank_statements = BankStatement.all
  end
  # GET /bank_statements/new
  def new
    @bank_statement = BankStatement.new
  end

  # GET /bank_statements/1/edit
  def edit
  end

  # POST /bank_statements or /bank_statements.json
  def create
    @bank_statement = BankStatement.new(bank_statement_params.merge(account: @account))

    respond_to do |format|
      if @bank_statement.save
        format.html { redirect_to bank_statements_url(@account), notice: "Bankový výpis bol úspešne vytvorený." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_statements/1 or /bank_statements/1.json
  def update
    respond_to do |format|
      if @bank_statement.update(bank_statement_params.merge(account: @account))
        format.html { redirect_to bank_statements_url(@account), notice: "Bankový výpis bol úspešne aktualizovaný." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_statements/1 or /bank_statements/1.json
  def destroy
    @bank_statement.destroy
    respond_to do |format|
      format.html { redirect_to bank_statements_url, notice: "Bankový výpis bol úspešne zmazaný." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_statement
      @bank_statement = BankStatement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_statement_params
      params.require(:bank_statement).permit(:account_id, :bank_account_id, :number, :serial_number, :accounting_period_month, :accounting_period_year, :delivery_date, :date_of_issue,
                                             bank_statement_items_attributes: [:id, :description,:settlement_date,:amount, :_destroy])
    end
end
