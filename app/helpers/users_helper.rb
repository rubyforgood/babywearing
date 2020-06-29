# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    user.name.initials
  end

  def user_roles_select
    User.roles.keys.map { |role| [role.humanize, role] }
  end

  def membership_status(user)
    return 'None' if user.memberships.empty?

    latest = user.latest_membership
    return 'Expired' if latest.expired?

    latest.blocked? ? 'Blocked' : 'Current'
  end
end
