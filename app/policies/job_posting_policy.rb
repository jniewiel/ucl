# app/policies/job_posting_policy.rb

class JobPostingPolicy < ApplicationPolicy 
  def show?
    record.user == user
  end
  
  def create?
    true
  end
  
  def update?
    record.user == user
  end
  
  def destroy?
    record.user == user
  end
  
  def select?
    true
  end
  
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
