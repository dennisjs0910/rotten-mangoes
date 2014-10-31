class Admin::UsersController < ApplicationController
  
  def index
    @users = User.where(admin: false).page(params[:page]).per(10)
  end  

  def show
    @user = User.find(params[:id])
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
    respond_to do |format|
      if @user.destroy
        # Tell the UserMailer to send a goodbye email after destroy
        UserMailer.bye_email(@user).deliver
 
        format.html { redirect_to(admin_users_path, notice: 'User was successfully deleted.') }
        format.json { render json: @user, status: :destroyed, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    

  end

  protected

  def user_params


    params.require(:user).permit(
      :email, :password, :admin, :firstname, :lastname
      )
  end

end
