# frozen_string_literal: true

class LocationPolicy < ApplicationPolicy
  attr_reader :user, :location

  def initialize(user, location)
    @user = user
    @location = location
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
