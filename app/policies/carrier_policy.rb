# frozen_string_literal: true

class CarrierPolicy < ApplicationPolicy
  attr_reader :user, :carrier

  def initialize(user, carrier)
    @user = user
    @carrier = carrier
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
