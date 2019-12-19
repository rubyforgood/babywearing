# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :members

  def initialize(user, members)
    @user = user
    @members = members
  end

  def index?
    authorized?
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
    user && (user.admin? || user.volunteer?)
  end
end
