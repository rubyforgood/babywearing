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

  private

  def authorized?
    user.admin? || user.volunteer?
  end
end
