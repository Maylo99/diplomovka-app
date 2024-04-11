class Account < ApplicationRecord
  belongs_to :invoice_account
  has_many :user_accounts
  has_many :users, :through => :user_accounts
  has_many :bank_accounts
  has_many :partners
  has_many :expenses
  enum accounting_type: { simple: 'Jednoduché účtovníctvo', double_entry: 'Podvojné účtovníctvo', flat_rate_expenses: 'Paušálne výdavky' }
  enum legal_form: { legal_person: 'Spoločnosť s ručením obmedzeným', natural_person: "Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri" }
  enum country: { sk: 'Slovensko' }

  def self.my_accounts(user)
    includes(:users)
      .where(users: { id: user.id })
      .collect { |a| [a.name, a.id] }
  end

end
