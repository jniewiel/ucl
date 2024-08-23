# <!-- app/controllers/home_controller.rb -->

class HomeController < ApplicationController
  include Pundit::Authorization

  def index
  end

  def guest_login
    # Authorize the guest login action using Pundit policy
    authorize :home, :guest_login?

    # Find or create a guest user with a predefined email
    ## Comment: Move a service object to handle the guest user creation
    guest_user = User.find_or_create_by!(email: "guest@example.com") do |user|
      # Set a random password for the guest user
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
    end

    sign_in(guest_user)
    redirect_to root_path, notice: "Signed in as guest."
  end

  def ucl_test
    # Authorize the UCL test action using Pundit policy
    authorize :home, :ucl_test?
    # Redirect to the 'home#test' path with a notice
    redirect_to 'home#test', notice: "Testing UCL."
  end

  def ucl_new
    # Authorize the UCL new action using Pundit policy
    authorize :home, :ucl_new?
    # Redirect to the 'cover_letters#new' path with a notice
    redirect_to 'cover_letters#new', notice: "Creating new UCL."
  end
end
