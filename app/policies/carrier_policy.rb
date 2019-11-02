# frozen_string_literal: true

class CarrierPolicy < ApplicationPolicy
  attr_reader :user, :carrier

  def initialize(user, carrier)
    @user = user
    @carrier = carrier
  end

  def new?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  def create?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  def edit?
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
    @user.has_any_role?(*roles)
  end
end
