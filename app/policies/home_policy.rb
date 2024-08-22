# app/policies/home_policy.rb

class HomePolicy < ApplicationPolicy
  def guest_login?
    # Allow all users to perform guest login
    true
  end

  def ucl_test?
    # Allow all users to perform the UCL test
    true
  end

  def ucl_new?
    # Allow all users to perform the UCL new action
    true
  end
end
