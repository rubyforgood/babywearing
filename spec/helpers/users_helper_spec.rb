# frozen_string_literal: true

RSpec.describe UsersHelper do
  describe "#user_roles_select" do
    it "returns user roles formated for rails select" do
      result = helper.user_roles_select
      expect(result).to eq [%w[Admin admin], %w[Volunteer volunteer], %w[Member member]]
    end
  end
end
