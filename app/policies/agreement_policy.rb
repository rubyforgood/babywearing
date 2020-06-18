# frozen_string_literal: true

class AgreementPolicy < ApplicationPolicy
  attr_reader :user, :agreement

  def initialize(user, agreement)
    @user = user
    @agreement = agreement
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
