class User < ApplicationRecord
  has_many :user_accounts
  has_many :accounts, :through => :user_accounts
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def default_account
    self.user_accounts.find_by(default: true).account
  end
end
