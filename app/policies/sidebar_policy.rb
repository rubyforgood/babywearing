# frozen_string_literal: true

SidebarPolicy = Struct.new(:user, :sidebar) do
  def show?
    user && (user.admin? || user.volunteer?)
  end
end
