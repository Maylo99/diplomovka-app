class BankAccount < ApplicationRecord
  belongs_to :account

  def unmap_account_id
    account=account_id
    self.update(account_id: nil)
    BankAccount.where(account_id: account).order(:created_at).first&.update(default: true) if default
  end
end
