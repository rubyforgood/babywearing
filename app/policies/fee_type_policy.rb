# frozen_string_literal: true

class FeeTypePolicy < ApplicationPolicy
  attr_reader :user, :fee_type

  def initialize(user, fee_type)
    @user = user
    @fee_type = fee_type
  end

  def create?
    authorized_admin?
  end

  def destroy?
    authorized_admin?
  end

  def edit?
    authorized_admin?
  end

  def index?
    authorized_admin?
  end

  def new?
    authorized_admin?
  end

  def show?
    authorized_admin?
  end

  def update?
    authorized_admin?
  end
end
