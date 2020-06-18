# frozen_string_literal: true

class MembershipTypePolicy < ApplicationPolicy
  attr_reader :user, :membership_type

  def initialize(user, membership_type)
    @user = user
    @membership_type = membership_type
  end

  def new?
    authorized_admin?
  end

  def create?
    authorized_admin?
  end

  def edit?
    authorized_admin?
  end

  def update?
    authorized_admin?
  end

  def destroy?
    authorized_admin?
  end
end
