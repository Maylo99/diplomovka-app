# frozen_string_literal: true
module Documentable
  def set_document_number(account_id)
    document = Invoice::my_last_invoice_in_year(account_id,DateTime.now.year)
    if document.nil?
      Date.current.year.to_s+"001"
    else
      invoice_number = document.number[4..-1].to_i + 1
      if invoice_number != 0 and invoice_number < 10
        (Date.current.year.to_s) + "00" + (invoice_number.to_s)
      elsif invoice_number > 9 and invoice_number < 100
        (Date.current.year.to_s) + "0" + (invoice_number.to_s)
      else
        (Date.current.year.to_s) + (invoice_number.to_s)
      end
    end
  end
end
