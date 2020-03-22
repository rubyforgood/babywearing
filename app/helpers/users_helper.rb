# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    user.name.initials
  end

  def user_roles_select
    User.roles.keys.map { |role| [role.humanize, role] }
  end

  def membership_status(user)
    return "No Membership" if user.memberships.empty?

    current = user.current_membership
    return "Expired" unless current.present?

    current.blocked? ? "Blocked" : "Current"
  end
end
