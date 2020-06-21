# frozen_string_literal: true

class LocationPolicy < ApplicationPolicy
  attr_reader :user, :location

  def initialize(user, location)
    @user = user
    @location = location
  end

  def index?
    authorized_admin?
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
