# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :membership

  def initialize(user, membership)
    @user = user
    @membership = membership
  end

  def new?
    authorized?
  end

  def create?
    authorized?
  end

  def edit?
    authorized?
  end

  def update?
    authorized?
  end

  def destroy?
    authorized?
  end

  private

  def authorized?
    user.admin? || user.volunteer?
  end
end
