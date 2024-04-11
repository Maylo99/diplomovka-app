# frozen_string_literal: true

class ChargeExpensesController < ExpensesController
  def expense_type
    "vpd"
  end
  def index_path
    income_expenses_path(@account)
  end
  def new_path
    new_income_expense_path(@account)
  end

  def edit_path
    edit_income_expense_path(@account,@expense)
  end

  def update_url
    income_expense_path(@account,@expense)
  end
end
