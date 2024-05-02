class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[ show edit update destroy ]
  before_action :set_account
  before_action :authenticate_user!



  # GET /bank_accounts or /bank_accounts.json
  def index
    @bank_accounts = BankAccount.where(account_id: @account.id)
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # POST /bank_accounts or /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)

    respond_to do |format|
      if @bank_account.save
        format.html { redirect_to bank_accounts_url(@account), notice: "Bank account was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1 or /bank_accounts/1.json
  def update
    @bank_account = BankAccount.find_or_initialize_by(bank_account_params)
    respond_to do |format|
      if @bank_account.new_record?
        if @bank_account.save
          BankAccount.find_by_id(params[:id]).unmap_account_id
          format.html { redirect_to bank_account_url(@account,@bank_account), notice: "Bank account was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to bank_account_url(@account,@bank_account), notice: "Žiadna zmena nebola vykonaná" }
      end
    end
  end

  # DELETE /bank_accounts/1 or /bank_accounts/1.json
  def destroy
    @bank_account.unmap_account_id

    respond_to do |format|
      format.html { redirect_to bank_accounts_url, notice: "Bank account was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_account_params
      params[:bank_account][:account_id] = @account.id
      params.require(:bank_account).permit(:name, :currency, :iban, :swift_code, :account_number, :bank_code, :account_id)
    end
end
