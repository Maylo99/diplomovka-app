class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_last_accessed_account
  before_action :set_locale


  def set_account
    account_id = params[:account_id]
    if !(account_id.is_integer?)
      flash[:alert] = "Account ID nie je číslo!"
      redirect_to root_path
    else
      account_id_in_url_logic(account_id)
    end
  end
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = params[:locale]
    elsif session[:locale]
      I18n.locale = session[:locale]
    else
      #I18n.locale = params[:lang] || locale_from_header || I18n.default_locale
      I18n.locale = "sk"
    end
  end

  def set_last_accessed_account
    return unless current_user
    account_id = params[:account_id]
    if valid_account_id?(account_id) && user_has_access_to_account?(account_id)
      session[:last_accessed_account_id] = account_id
    end
    @account_id = session[:last_accessed_account_id] || current_user.default_account&.id
    redirect_to new_account_path unless @account_id
  end

  private
  def valid_account_id?(account_id)
    account_id.to_i.to_s == account_id && account_id.to_i.positive?
  end

  def user_has_access_to_account?(account_id)
    UserAccount.exists?(user_id: current_user.id, account_id:)
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

  def require_login
    unless current_user
      redirect_to new_user_session_path
    end
  end
end
