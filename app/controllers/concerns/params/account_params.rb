# frozen_string_literal: true

module Params::AccountParams

  private
  def account_params
    params.require(:account).permit(:name, :accounting_type, :register_text, :legal_form_id, :country_id, :address_match).except(:country_id, :address_match)
  end

  def account_logo_params
    params[:account][:logo]
  end

  def account_signature_params
    params[:account][:signature]
  end

end