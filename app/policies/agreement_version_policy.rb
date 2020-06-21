# frozen_string_literal: true

class AgreementVersionPolicy < ApplicationPolicy
  attr_reader :user, :agreement_version

  def initialize(user, agreement_version)
    @user = user
    @agreement_version = agreement_version
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
