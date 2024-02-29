class AccountsController < ApplicationController
  include Params::AddressParams
  include Params::InvoiceAccountParams
  include Params::AccountParams
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    @invoice_account = InvoiceAccount.new
    @invoice_address = Address.new
    @postal_address = Address.new
  end

  # GET /accounts/1/edit
  def edit
    @invoice_account = @account.invoice_account
    @invoice_address = @invoice_account.invoice_address
    @postal_address = @invoice_account.postal_address.nil? ? Address.new : @invoice_account.postal_address
  end

  # POST /accounts or /accounts.json
  def create
    begin
      ActiveRecord::Base.transaction do
        @invoice_address = Address.find_or_create_by(address_params(:invoice_address))
        params[:account][:address_match] == "0" ? @postal_address = Address.find_or_create_by(@address_params) : @postal_address = Address.new
        @invoice_account = InvoiceAccount.find_or_create_by(invoice_account_params(:invoice_account).
          merge({ :invoice_address_id => @invoice_address.id,
                  :postal_address_id => @postal_address&.id
                }))
        @account = Account.new(account_params.merge({ invoice_account_id: @invoice_account.id }))
        is_persisted = @account.save
        unless is_persisted
          raise ActiveRecord::RecordInvalid
        end
        user = current_user
        user.user_accounts.create!(user_id: user.id, account_id: @account.id)
        if user.accounts.count === 1
          user.user_accounts.first.update(default: true)
        end
      end
    rescue  ActiveRecord::RecordInvalid
      @invoice_address.validate
      @postal_address.validate
      @invoice_account.validate
      @account.validate
    end

    respond_to do |format|
      if @account.persisted?
        format.html { redirect_to account_url(@account), notice: "Account was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    begin
      ActiveRecord::Base.transaction do
        @invoice_address = Address.find_or_create_by(address_params(:invoice_address))
        params[:account][:address_match] == "0" ? @postal_address = Address.find_or_create_by(@address_params) : @postal_address = Address.new
        @invoice_account = InvoiceAccount.find_or_create_by(invoice_account_params(:invoice_account).
          merge({ :invoice_address_id => @invoice_address.id,
                  :postal_address_id => @postal_address&.id
                }))
        @is_updated= @account.update(account_params.merge({ invoice_account_id: @invoice_account.id }))
        unless @is_updated
          raise ActiveRecord::RecordInvalid
        end
      end
    rescue  ActiveRecord::RecordInvalid
      @invoice_address.validate
      @postal_address.validate
      @invoice_account.validate
      @account.validate
    end
    respond_to do |format|
      if @is_updated
        format.html { redirect_to account_url(@account), notice: "Account was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find_by_id(params[:account_id])
  end
end
