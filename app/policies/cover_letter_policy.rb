# app/policies/cover_letter_policy.rb

class CoverLetterPolicy < ApplicationPolicy 
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
  
  def generate?
    true
  end
  
  def save?
    true
  end
  
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
