class BankStatement < ApplicationRecord
  belongs_to :account
  belongs_to :bank_account
  has_many :bank_statement_items,dependent: :destroy
  accepts_nested_attributes_for :bank_statement_items, allow_destroy: true
  enum accounting_period_month: {
    "1" => "Január",
    "2" => "Február",
    "3" => "Marec",
    "4" => "Apríl",
    "5" => "Máj",
    "6" => "Jún",
    "7" => "Júl",
    "8" => "August",
    "9" => "September",
    "10" => "Október",
    "11" => "November",
    "12" => "December"
  }
  validates :number, presence: true
end
