# app/policies/resume_policy.rb

class ResumePolicy < ApplicationPolicy 
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
