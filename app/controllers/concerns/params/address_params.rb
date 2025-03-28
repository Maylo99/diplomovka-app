# frozen_string_literal: true

module Params::AddressParams

  private

  def address_params(model_name)
    begin
      params.require(model_name).permit(:name, :contact, :country_id, :street, :city, :postal_code, :street_number, :register_number)
    rescue ActionController::ParameterMissing
      nil
    end
  end

end
