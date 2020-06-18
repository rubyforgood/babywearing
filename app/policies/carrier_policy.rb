# frozen_string_literal: true

class CarrierPolicy < ApplicationPolicy
  attr_reader :user, :carrier

  def initialize(user, carrier)
    @user = user
    @carrier = carrier
  end

  def new?
    authorized_admin?
  end

  def create?
    authorized_admin?
  end

  def edit?
    authorized_admin_or_volunteer?
  end

  def update?
    authorized_admin_or_volunteer?
  end

  def destroy?
    authorized_admin_or_volunteer?
  end

  def checkout?
    authorized_admin_or_volunteer?
  end

  # def authorized_admin_only?
  #   user && (user.admin? || user.volunteer?)
  # end
  #
  # def authorized_admin_only?
  #   user && (user.admin? || user.volunteer?)
  # end
end
