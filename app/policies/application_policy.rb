# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :users

  def initialize(user, users)
    @user = user
    @users = users
  end

  def authorized_admin?
    user&.admin?
  end

  def authorized_admin_or_volunteer?
    user && (user.admin? || user.volunteer?)
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
