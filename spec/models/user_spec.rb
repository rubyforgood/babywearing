require 'rails_helper'

RSpec.describe User do
  describe "Associations" do
    it "should have a role" do
      test_user = User.reflect_on_association(:roles)
      expect(test_user.macro).to eq(:has_and_belongs_to_many)
    end
  end
end