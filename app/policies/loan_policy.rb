# frozen_string_literal: true

class LoanPolicy < ApplicationPolicy
  attr_reader :user, :loan

  def initialize(user, loan)
    @user = user
    @loan = loan
  end

  def new?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  def create?
    roles = [:admin, :volunteer]
    authorized?(roles)
  end

  private

  def authorized?(roles)
    @user.has_any_role?(*roles)
  end
end
