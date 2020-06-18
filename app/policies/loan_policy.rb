# frozen_string_literal: true

class LoanPolicy < ApplicationPolicy
  attr_reader :user, :loan

  def initialize(user, loan)
    @user = user
    @loan = loan
  end

  def create?
    authorized_admin_or_volunteer?
  end

  def edit?
    authorized_admin_or_volunteer?
  end

  def index?
    authorized_admin_or_volunteer?
  end

  def new?
    authorized_admin_or_volunteer?
  end

  def update?
    authorized_admin_or_volunteer?
  end
end
