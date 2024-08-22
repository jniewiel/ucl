# app/policies/resume_policy.rb

class ResumePolicy < ApplicationPolicy
  def show?
    # Only the owner of the resume can view it
    record.user == user
  end

  def create?
    # Allow all users to create a resume
    true
  end

  def update?
    # Only the owner of the resume can update it
    record.user == user
  end

  def destroy?
    # Only the owner of the resume can destroy it
    record.user == user
  end

  def select?
    # Allow all users to select resumes
    true
  end

  # Scope class to define which records a user can access
  class Scope < Scope
    def resolve
      # Return only the resumes that belong to the user
      scope.where(user: user)
    end
  end
end
