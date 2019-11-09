# frozen_string_literal: true

class AgreementPolicy < ApplicationPolicy
  attr_reader :user, :agreement

  def initialize(user, agreement)
    @user = user
    @agreement = agreement
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
