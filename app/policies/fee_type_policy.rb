# frozen_string_literal: true

class FeeTypePolicy < ApplicationPolicy
  attr_reader :user, :fee_type

  def initialize(user, fee_type)
    @user = user
    @fee_type = fee_type
  end

  def create?
    authorized?
  end

  def destroy?
    authorized?
  end

  def edit?
    authorized?
  end

  def new?
    authorized?
  end

  def show?
    authorized?
  end

  def update?
    authorized?
  end

  private

  def authorized?
    user.admin? || user.volunteer?
  end
end
