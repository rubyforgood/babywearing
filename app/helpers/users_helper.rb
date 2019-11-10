# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    user.name.initials
  end

  def user_can_add_new_member(user)
    user.admin? || user.volunteer?
  end

  def user_roles_select
    User.roles.keys.map { |role| [role.humanize, role] }
  end
end
