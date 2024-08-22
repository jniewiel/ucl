# app/policies/cover_letter_policy.rb

class CoverLetterPolicy < ApplicationPolicy 
  def show?
    # A user can view a cover letter if they are the owner of it
    record.user == user
  end
  
  def create?
    # Allow all users to create a cover letter
    true
  end
  
  def update?
    # A user can update a cover letter if they are the owner of it
    record.user == user
  end
  
  def destroy?
    # A user can delete a cover letter if they are the owner of it
    record.user == user
  end
  
  # Check if the user is authorized to generate a cover letter
  def generate?
    # Allow all users to generate a cover letter
    true
  end
  
  def save?
    # Allow all users to save a cover letter
    true
  end
  
  # Scope class to define which records a user can access
  class Scope < Scope
    def resolve
      # Return only the cover letters that belong to the user
      scope.where(user: user)
    end
  end
end
