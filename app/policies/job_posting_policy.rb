# app/policies/job_posting_policy.rb

class JobPostingPolicy < ApplicationPolicy
  def show?
    # Only the owner of the job posting can view it
    record.user == user
  end

  def create?
    # Allow all users to create a job posting
    true
  end

  def update?
    # Only the owner of the job posting can update it
    record.user == user
  end

  def destroy?
    # Only the owner of the job posting can destroy it
    record.user == user
  end

  def select?
    # Allow all users to select job postings
    true
  end

  # Scope class used to define which records a user can access
  class Scope < Scope
    def resolve
      # Return only the job postings that belong to the user
      scope.where(user: user)
    end
  end
end
