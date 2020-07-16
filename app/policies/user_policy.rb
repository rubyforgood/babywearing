# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :users

  def initialize(user, users)
    @user = user
    @users = users
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

  def show?
    authorized?
  end

  def permitted_attributes
    all_attributes = User.attribute_names.to_a.map(&:to_sym)

    user.admin? ? all_attributes : all_attributes - [:role]
  end

  private

  def authorized?
    user && (user.admin? || user.volunteer?)
  end
end
