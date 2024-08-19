# app/policies/home_policy.rb

class HomePolicy < ApplicationPolicy
  def guest_login?
    true
  end

  def ucl_test?
    true
  end

  def ucl_new?
    true
  end
end
