class AccountsController < ApplicationController
  before_action :no_guests
  before_action :set_account, :except: [:new]

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

  def edit
  end

  def update
  end

  def transfer
  end

  def destroy
  end

  def show
  end

  private

  def no_guests
    back_or root_url if !logged_in?
  end

  def set_account
    if params[:type] == "checking"
      @account = Checking_Account.find(params[:id])
    else
      @account = Savings_Account.find(params[:id])
    end
  end
end
