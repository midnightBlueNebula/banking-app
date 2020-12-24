class SessionsController < ApplicationController
  before_action :deny_online_user, except: [:destroy]

  def new
  end

  def create
    email = params[:session][:email]

    if (user = User.find_by(email: email))
      if (user.autheticate(params[:session][:password]))
        if user.confirmed?
          login user
          params[:session][:remember] == '1' ? remember(user) : forget(user)
          flash[:success] = "Logged in."
          back_or "/user/profile/#{user.id}"
        else
          flash[:warning] = "This account didn't confirmed yet."
        end
      else
        flash[:error] = "Wrong email or password entered."
      end
    else
      flash[:error] = "No registered account find by e-mail: #{email]}"
    end
  end

  def destroy
    back_or root_url if !logged_in?
    logout  
    back_or root_url 
  end

  private

  def deny_online_user
    redirect_to "/user/profile/#{current_user.id}" if logged_in?
  end
end
