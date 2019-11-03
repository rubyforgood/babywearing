# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    user.name.initials
  end

  def user_can_add_new_member(user)
    user.has_role?(:admin) || user.has_role?(:volunteer)
  end
end
