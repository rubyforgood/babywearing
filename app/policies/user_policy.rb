# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :members

  def initialize(user, members)
    @user = user
    @members = members
  end

  def index?
    user.has_role?(:admin) or user.has_role?(:volunteer)
  end
end
