class Partner < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :client, foreign_key: 'client_id', class_name: "InvoiceAccount"

  validates :name, presence: true

  def unmap_account_id
    self.update(account_id: nil)
  end
end
