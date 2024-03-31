# frozen_string_literal: true

module Params::InvoiceAccountParams

  private

  def invoice_account_params(model_name)
    begin
    params.require(model_name).permit(:vat_payer_type, :registration_id, :tax_id, :vat_id, :phone_number, :email, :web)
    rescue ActionController::ParameterMissing
      nil
    end
  end

end
