# frozen_string_literal: true

class MembershipTypePolicy < ApplicationPolicy
  attr_reader :user, :membership_type

  ROLES = [:admin, :volunteer]

  def initialize(user, membership_type)
    @user = user
    @membership_type = membership_type
  end

  def new?
    authorized?(ROLES)
  end

  def create?
    authorized?(ROLES)
  end

  def edit?
    authorized?(ROLES)
  end

  def update?
    authorized?(ROLES)
  end

  def destroy?
    authorized?(ROLES)
  end

  private

  def authorized?(roles)
    @user.has_any_role?(*roles)
  end
end
