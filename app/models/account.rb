class Account < ApplicationRecord
  belongs_to :invoice_account
  has_many :user_accounts
  enum accounting_type: { simple: 'Jednoduché účtovníctvo', double_entry: 'Podvojné účtovníctvo', flat_rate_expenses: 'Paušálne výdavky' }
  enum legal_form: {legal_person: 'Spoločnosť s ručením obmedzeným', natural_person: "Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri"  }
  enum country: {sk: 'Slovensko'}

end
