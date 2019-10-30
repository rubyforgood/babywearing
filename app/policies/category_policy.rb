# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :category

  ROLES = [:admin, :volunteer]

  def initialize(user, category)
    @user = user
    @category = category
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
