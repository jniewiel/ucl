# app/policies/application_policy.rb

class ApplicationPolicy
  attr_reader :user, :record

  # Initialize the policy with the current user and the record being accessed
  def initialize(user, record)
    @user = user
    @record = record
  end

  # Default policy methods; these can be overridden in subclasses
  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # Scope class used to handle record scoping based on user permissions
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # Must be implemented in subclasses to define how records are scoped
    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
