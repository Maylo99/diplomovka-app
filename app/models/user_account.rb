class UserAccount < ApplicationRecord
  belongs_to :user
  belongs_to :account

  enum user_role: { owner: 'Majiteľ firmy', accountant: 'Účtovník' }, _default: :owner
end
