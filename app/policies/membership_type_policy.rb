# frozen_string_literal: true

class MembershipTypePolicy < ApplicationPolicy
  attr_reader :user, :membership_type

  def initialize(user, membership_type)
    @user = user
    @membership_type = membership_type
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
