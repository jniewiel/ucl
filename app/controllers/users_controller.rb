# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def create
    # Initialize a new user with permitted parameters and authorize the user
    @user = User.new(user_params)
    authorize(@user)

    if @user.save
      # Redirect to the root URL with a success notice if the user is created
      redirect_to(root_url, notice: "User was successfully created.")
    else
      # Redirect to the root URL with an unprocessable entity status if save fails
      redirect_to(root_url, status: :unprocessable_entity)
    end
  end

  def update
    # Find the user by ID, authorize the user for update
    @user = User.find(params[:id])
    authorize(@user)

    if @user.update(user_params)
      # Redirect to the user's show page with a success notice if update is successful
      redirect_to(@user, notice: "User was successfully updated.")
    else
      # Render the root URL template with an unprocessable entity status if update fails
      render template: 'home/index', status: :unprocessable_entity
    end
  end

  def destroy
    # Find the user by ID, authorize the user for destruction
    @user = User.find(params[:id])
    authorize(@user)

    @user.destroy

    # Redirect back to the previous page or fallback to the root URL with a success notice
    redirect_back(fallback_location: root_url, notice: "User was successfully destroyed.")
  end

  private

  # Permit only the trusted parameters for user creation and updating
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
