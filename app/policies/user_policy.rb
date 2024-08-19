# app/policies/user_policy.rb

class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user == record
  end

  def destroy?
    user.admin? || user == record
  end
end
