class UsersController < ApplicationController
  before_action :set_user             , except: [:new, :create]
  before_action :must_be_offline      , only:   [:new, :create]
  before_action :must_be_user         , only:   [:edit]
  before_action :must_be_admin        , only:   [:destroy]
  before_action :must_be_admin_or_user, only:   [:show]


  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Account created successfully."
      redirect_to root_url
    else
      flash[:error] = "Failed to create account."
      back_or root_url
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account edited successfully."
      redirect_to "/user/profile/#{@user.id}"
    else
      flash[:error] = "Failed to update."
      back_or root_url
    end
  end

  def show
  end

  def destroy
    if @user.delete
      flash[:success] = "User deleted successfully."
    else  
      flash[:error] = "Failed to delete User."
    end

    back_or root_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, 
                   :password, :password_confirmation)
  end

  def must_be_offline 
    back_or root_url if logged_in?
  end

  def must_be_user
    back_or root_url if current_user != set_user
  end

  def must_be_admin
    back_or root_url if !current_user.is_admin?
  end

  def must_be_admin_or_user
    back_or root_url if current_user != set_user 
                     && !current_user.is_admin?
  end
end
