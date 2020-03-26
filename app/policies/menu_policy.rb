# frozen_string_literal: true

MenuPolicy = Struct.new(:user, :menu) do
  def show?
    user && (user.admin? || user.volunteer?)
  end
end
