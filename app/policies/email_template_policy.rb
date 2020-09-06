# frozen_string_literal: true

class EmailTemplatePolicy < ApplicationPolicy
  attr_reader :user, :email_template

  def initialize(user, email_template)
    @user = user
    @email_template = email_template
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
