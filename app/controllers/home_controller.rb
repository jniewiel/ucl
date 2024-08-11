# <!-- app/controllers/home_controller.rb -->

class HomeController < ApplicationController
  def index
  end

  def guest_login
    guest_user = User.find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
    end

    sign_in(guest_user)
    redirect_to root_path, notice: "Signed in as guest."
  end

  def ucl_test
    redirect_to 'home#test', notice: "Testing UCL."
  end

  def ucl_new
    redirect_to 'cover_letters#new', notice: "Creating new UCL."
  end
end
