class BankAccount < ApplicationRecord
  belongs_to :account, optional: true
  has_many :invoice_bank_accounts
  validates :name,presence: true

  def unmap_account_id
    account = account_id
    self.update(account_id: nil)
  end

  def self.my_bank_accounts(account_id)
    where(account_id: account_id)
  end
end
