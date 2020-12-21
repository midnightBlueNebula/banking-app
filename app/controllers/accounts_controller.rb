class AccountsController < ApplicationController
  before_action :no_guests
  before_action :set_account, except: [:new, :transfer]
  before_action :must_be_user, only: [:new, :create] 
  before_action :must_be_admin_or_user, only: [:transfer,
                                               :destroy,
                                               :show]

  def new
  end

  def create
    account_params = params[:account]

    if account_params[:type] == "checking"
      @account = current_user.checking_accounts.build(balance: account_params[:balance],
                                                      currency: account_params[:currency])
      
      if @account.save
        flash[:success] = "Checking account created."
        redirect_to "accounts/#{checking}/view/#{@account.id}"
      else
        flash[:error] = "Failed to create checking account."
        back_or root_url
      end
    else
      @account = current_user.savings_accounts.build(balance: account_params[:balance],
                                                     currency: account_params[:currency], 
                                                    interest: calculate_interest(account_params[:balance],
                                                                                 account_params[:currency]))
      
      if @account.save
        flash[:success] = "Savings account created."
        redirect_to "accounts/#{savings}/view/#{@account.id}"
      else
        flash[:error] = "Failed to create savings account."
        back_or root_url
      end
    end
  end

  def transfer
    base_account = CheckingAccount.find(params[:base_account][:id])
    target_account = CheckingAccount.find(params[:target_account][:id])
  end

  def destroy
    if params[:type] == "checking"
      if current_user.checking_accounts.count == 1
        flash[:error] = "Failed to delete account: You must have at least 1 checking account."
        back_or root_url
      else
        close_account(@account, @account.user.checking_accounts.first)

        if @account.delete
          flash[:success] = "Account closed."
          back_or root_url if current_user.is_admin?
          redirect_to "/user/profile/#{current_user.id}"
        else
          flash[:error] = "Failed to delete acccount, but balance transfered into main account."
          back_or root_url
        end
      end
    else
      close_account(@account, @account.user.checking_accounts.first)

      if @acccount.delete
          flash[:success] = "Account closed."
          back_or root_url if current_user.is_admin?
          redirect_to "/user/profile/#{current_user.id}"
      else
          flash[:error] = "Failed to delete acccount, but balance transfered into main account."
          back_or root_url
      end
    end
  end

  def show
  end

  private

  def no_guests
    back_or root_url if !logged_in?
  end

  def set_account
    if params[:type] == "checking"
      @account = CheckingAccount.find(params[:id])
    else
      @account = SavingsAccount.find(params[:id])
    end
  end

  def must_be_user
    back_or root_url if current_user != set_account.user
  end

  def must_be_admin
    back_or root_url if !current_user.is_admin?
  end

  def must_be_admin_or_user
    back_or root_url if current_user != set_account.user 
                     && !current_user.is_admin?
  end
end
