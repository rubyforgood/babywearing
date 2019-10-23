class CarrierPolicy < ApplicationPolicy
  attr_reader :user, :members

  def initialize(user, members)
    @user = user
    @members = members
  end

  def create?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  def update?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  def destroy?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  private
    def authorized?(roles)
      for role in roles
        if user.has_role?(role)
          return true
        end
      end
      return false
    end
end
