# frozen_string_literal: true

class MainBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def index
    @plutus_accounts = Plutus::Account.where("name LIKE ?", "%#{params[:plutus_account]}%").where(tenant: @account)
    @d = []
    @md = []
    @plutus_accounts.each do |pl_account|
      @md += pl_account.debit_entries
      @d += pl_account.credit_entries
    end
    @plutus_account = @plutus_accounts.first
    @plutus_account = Plutus::Account.first unless @plutus_account
  end
end
