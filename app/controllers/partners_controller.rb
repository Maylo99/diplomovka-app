class PartnersController < ApplicationController
  include Params::AddressParams
  include Params::InvoiceAccountParams
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_partner, only: %i[ show edit update destroy ]

  # GET /partners or /partners.json
  def index
    @partners =@account.partners
  end

  # GET /partners/new
  def new
    @partner = @account.partners.build
    @invoice_account = InvoiceAccount.new
    @address = Address.new
    @postal_address = Address.new
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find_by_id(params[:id])
    @invoice_account = @partner.client
    @address = @invoice_account.invoice_address
    @postal_address = @invoice_account.postal_address.nil? ? Address.new : @invoice_account.postal_address
  end

  # POST /partners or /partners.json
  def create
    ActiveRecord::Base.transaction do
      begin
        @address = Address.find_or_create_by(address_params(:address))
        @postal_address = Address.find_or_create_by(address_params(:postal_address))
        @invoice_account = InvoiceAccount.find_or_create_by(invoice_account_params(:invoice_account).
          merge({ :invoice_address_id => @address.id,
                  :postal_address_id => @postal_address&.id
                }))
        @partner = @account.partners.build(partner_params.merge({ :account_id => @account.id, :client_id => @invoice_account.id}))
        @partner.save!
      rescue ActiveRecord::RecordInvalid
        @partner.validate
        @postal_address.validate
        @address.validate
        @invoice_account.validate
      end
    end

    respond_to do |format|
      if @partner.persisted?
        format.html { redirect_to partner_url(@account,@partner), notice: "Partner was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partners/1 or /partners/1.json
  def update
    Partner.transaction do
      @address = Address.find_or_create_by(address_params(:address))
      @postal_address = Address.find_or_create_by(address_params(:postal_address))
      @invoice_account = InvoiceAccount.find_or_create_by(invoice_account_params(:invoice_account).merge({ :invoice_address_id => @address.id,
                                                                                                           :postal_address_id => @postal_address&.id }))
    end
    respond_to do |format|
      if  @partner.update(partner_params.merge({ :client_id => @invoice_account.id }))
        format.html { redirect_to partner_url(@partner), notice: "Partner was successfully updated." }
      else
        @partner.validate
        @postal_address.validate
        @address.validate
        @invoice_account.validate
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1 or /partners/1.json
  def destroy
    @partner.unmap_account_id

    respond_to do |format|
      format.html { redirect_to partners_url, notice: "Partner was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = Partner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def partner_params
      params.require(:partner).permit(:name)
    end
end
