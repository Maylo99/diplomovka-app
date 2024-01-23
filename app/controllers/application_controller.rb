class ApplicationController < ActionController::Base
  before_action :require_login


  def set_account
    account_id = params[:account_id]
    if !(account_id.is_integer?)
      flash[:alert] = "Account ID nie je číslo!"
      redirect_to root_path
    else
      account_id_in_url_logic(account_id)
    end
  end

  def account_id_in_url_logic(account_id)
    begin
      if UserAccount.where(:user_id => current_user.id, :account_id => account_id).empty?
        flash[:notice] = "Nemáš oprávnenie pre prístup k tomuto účtu!"
        redirect_to root_path
      else
        @account = Account.find(account_id)
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Takýto účet neexistuje skuste to znovu!"
      redirect_to root_path
    end
  end

  private
  def require_login
    unless current_user
      redirect_to new_user_session_path
    end
  end
end
