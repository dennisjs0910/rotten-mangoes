class Admin::UsersController < ApplicationController
  
  def index
    @users = User.where(admin: false).page(params[:page]).per(10)
  end  

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @admin = User.find(params[:id])
    @admin.update_att
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path

  end

  protected

  def user_params
    params.require(:user).permit(
      :email, :password, :admin, :firstname, :lastname
      )
  end

end
