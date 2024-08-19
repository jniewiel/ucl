# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    authorize(@user)

    if @user.save
      redirect_to(root_url, { :notice => "User was successfully created." })
    else
      redirect_to(root_url, { :status => :unprocessable_entity })
    end
  end

  def update
    @user = User.find(params[:id])
    authorize(@user)

    if @user.update(user_params)
      redirect_to(@user, { :notice => "User was successfully updated." })
    else
      render({ :template => root_url, :status => :unprocessable_entity })
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize(@user)

    @user.destroy
    
    redirect_back({ :fallback_location => root_url, :notice => "User was successfully destroyed." })
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
