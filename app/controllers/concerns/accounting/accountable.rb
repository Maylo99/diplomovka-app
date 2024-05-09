# frozen_string_literal: true

module Accounting::Accountable
  ACCOUNTS_TYPE_MAPPING = {
    '041': "Asset",
    '042': "Asset",
    '211': "Asset",
    '213': "Asset",
    '221': "Asset",
    '311': "Asset",
    '321': "Liability",
    '343md': "Asset",
    '343d': "Liability",
    '501': "Expense",
    '502': "Expense",
    '504': "Expense",
    '511': "Expense",
    '513': "Expense",
    '518': "Expense",
    '601': "Revenue",
    '602': "Revenue",
    '604': "Revenue",
    '641': "Revenue",
    '642': "Revenue"
  }

  def add_entry_to_account(document_items_params, document_items, account)
    entry_items = {}
    document_items_params.each do |k, v|
      if v[:description]
        document_item = document_items.find_by(description: v[:description], settlement_date: v[:settlement_date], amount: v[:amount])
        document_amount=v[:amount].to_d
        case_amount= v[:amount].to_d
        dph_amount=nil
        description=v[:description]
      else
        document_item = document_items.find_by(name: v[:name], quantity: v[:quantity], unit_price: v[:unit_price], vat_rate: v[:vat_rate])
        document_amount=v[:quantity].to_d * v[:unit_price].to_d + v[:quantity].to_d * v[:unit_price].to_d * v[:vat_rate].to_d / 100
        case_amount= v[:quantity].to_d * v[:unit_price].to_d
        dph_amount= v[:quantity].to_d * v[:unit_price].to_d * v[:vat_rate].to_d / 100
        description=v[:name]
      end
      entry_items[k] = { description: description,
                         case_account_input: v[:accounting_case_input],
                         case_account_select: v[:accounting_case_select],
                         case_amount: case_amount,
                         account_case_side: v[:accounting_case_side],
                         dph_account: v[:account_dph],
                         dph_account_side: v[:account_dph_side],
                         dph_amount: dph_amount,
                         account_document: v[:account_document],
                         account_document_side: v[:account_document_side],
                         document_amount: document_amount,
                         document_item: document_item }.compact
    end
    entry_items.each do |k, v|
      debit_accounts = []
      credit_accounts = []
      case_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[v[:case_account_input].to_sym]}".constantize.find_or_create_by(name: v[:case_account_input], tenant: account) if v[:case_account_input].present?
      case_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[v[:case_account_select].to_sym]}".constantize.find_or_create_by(name: v[:case_account_select], tenant: account) if v[:case_account_select]
      dph_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[(v[:dph_account] + v[:dph_account_side]).to_sym]}".constantize.find_or_create_by(name: v[:dph_account] + v[:dph_account_side], tenant: account) if v[:dph_account].present? && v[:dph_account_side].present?
      document_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[v[:account_document].to_sym]}".constantize.find_or_create_by(name: v[:account_document], tenant: account) if v[:account_document].present?
      debit_accounts, credit_accounts = sort_account(debit_accounts, credit_accounts, case_account, v[:account_case_side], v[:case_amount]) if case_account
      debit_accounts, credit_accounts = sort_account(debit_accounts, credit_accounts, dph_account, v[:dph_account_side], v[:dph_amount]) if dph_account
      debit_accounts, credit_accounts = sort_account(debit_accounts, credit_accounts, document_account, v[:account_document_side], v[:document_amount]) if document_account
      Plutus::Entry.create(
        :description => v[:description],
        commercial_document: v[:document_item],
        :date => Date.today,
        :debits => debit_accounts,
        :credits => credit_accounts)
    end
  end

  def update_entry_to_account(document_items_params, document_items, account)
    entry_items = {}
    document_items_params.each do |k, v|
      if v[:description]
        document_item = document_items.find_by(description: v[:description], settlement_date: v[:settlement_date], amount: v[:amount])
        document_amount=v[:amount].to_d
        case_amount= v[:amount].to_d
        dph_amount=nil
        description=v[:description]
      else
        document_item = document_items.find_by(name: v[:name], quantity: v[:quantity], unit_price: v[:unit_price], vat_rate: v[:vat_rate])
        document_amount=v[:quantity].to_d * v[:unit_price].to_d + v[:quantity].to_d * v[:unit_price].to_d * v[:vat_rate].to_d / 100
        case_amount= v[:quantity].to_d * v[:unit_price].to_d
        dph_amount= v[:quantity].to_d * v[:unit_price].to_d * v[:vat_rate].to_d / 100
        description=v[:name]
      end
      entry_items[k] = { description: description,
                         case_account_input: v[:accounting_case_input],
                         case_account_select: v[:accounting_case_select],
                         case_amount: case_amount,
                         account_case_side: v[:accounting_case_side],
                         dph_account: v[:account_dph],
                         dph_account_side: v[:account_dph_side],
                         dph_amount: dph_amount,
                         account_document: v[:account_document],
                         account_document_side: v[:account_document_side],
                         document_amount: document_amount,
                         document_item: document_item }.compact
    end
      entry_items.each do |k, v|
        debit_accounts = []
        credit_accounts = []
        case_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[v[:case_account_input].to_sym]}".constantize.find_or_create_by(name: v[:case_account_input], tenant: account) if v[:case_account_input].present?
        case_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[v[:case_account_select].to_sym]}".constantize.find_or_create_by(name: v[:case_account_select], tenant: account) if v[:case_account_select]
        dph_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[(v[:dph_account] + v[:dph_account_side]).to_sym]}".constantize.find_or_create_by(name: v[:dph_account] + v[:dph_account_side], tenant: account) if v[:dph_account].present? && v[:dph_account_side].present?
        document_account = "Plutus::#{ACCOUNTS_TYPE_MAPPING[v[:account_document].to_sym]}".constantize.find_or_create_by(name: v[:account_document], tenant: account) if v[:account_document].present?
        debit_accounts, credit_accounts = sort_account(debit_accounts, credit_accounts, case_account, v[:account_case_side], v[:case_amount]) if case_account
        debit_accounts, credit_accounts = sort_account(debit_accounts, credit_accounts, dph_account, v[:dph_account_side], v[:dph_amount]) if dph_account
        debit_accounts, credit_accounts = sort_account(debit_accounts, credit_accounts, document_account, v[:account_document_side], v[:document_amount]) if document_account
        old_entry = Plutus::Entry.where(commercial_document_id: v[:document_item].id).first
        old_entry_id = old_entry.id if old_entry
        Plutus::Amount.where(entry_id: old_entry_id).delete_all if old_entry
        old_entry.delete if old_entry
        Plutus::Entry.create(
          :description => v[:description],
          commercial_document: v[:document_item],
          :date => Date.today,
          :debits => debit_accounts,
          :credits => credit_accounts)
      end
  end

  private

  def sort_account(debit_accounts, credit_accounts, plutus_account, account_side, amount)
    account_side = account_side.downcase
    case account_side
    when "d"
      if plutus_account.kind_of?(Plutus::Asset) || plutus_account.kind_of?(Plutus::Expense)
        credit_accounts << { :account => plutus_account, :amount => amount }
      end
      if plutus_account.kind_of?(Plutus::Liability) || plutus_account.kind_of?(Plutus::Revenue)
        credit_accounts << { :account => plutus_account, :amount => amount }
      end
    when "md"
      if plutus_account.kind_of?(Plutus::Asset) || plutus_account.kind_of?(Plutus::Expense)
        debit_accounts << { :account => plutus_account, :amount => amount }
        # ako debit lebo ocakvam ubytok penazi
      end
      if plutus_account.kind_of?(Plutus::Liability) || plutus_account.kind_of?(Plutus::Revenue)
        debit_accounts << { :account => plutus_account, :amount => amount }
        # ako credit lebo ocakvam peniaze
      end
    end
    return debit_accounts, credit_accounts
  end
end
# 343 D chova sa ako zavazok
# 343 MD chova sa ako pohladavka
#
# aktivny ucet D ubudaju peniaze
# aktivny ucet MD pribudaju peniaze
#
# pasivny ucet D pribudaju peniaze
# pasivny ucet MD ubudaju peniaze
#
# def update_entry_to_account(items_params)
# accounting_cases.each do |key,account_case|
#   account_type= "Plutus::#{ACCOUNTS_TYPE_MAPPING[key.to_sym]}".constantize
#   my_account=account_type.find_or_create_by(name: key.to_s,tenant: working_account)
# end
# entry= Plutus::Entry.new()
# end