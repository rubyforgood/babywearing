# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    user.full_name.remove(/(\(|\[).*(\)|\])/).scan(/([[:word:]])[[:word:]]+/i).join
  end
end
