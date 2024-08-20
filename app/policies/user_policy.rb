# app/policies/user_policy.rb

class UserPolicy < ApplicationPolicy
  def create?
    # Allow all users to create a new user
    true
  end

  def update?
    # Only the user themselves can update their own record
    user == record
  end

  def destroy?
    # An admin can delete any user. Otherwise, only the user themselves can delete their own record
    user.admin? || user == record
  end
end
