# frozen_string_literal: true

class LocationPolicy < ApplicationPolicy
  attr_reader :user, :location

  ROLES = [:admin, :volunteer].freeze

  def initialize(user, location)
    @user = user
    @location = location
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
