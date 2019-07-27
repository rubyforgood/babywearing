require 'rails_helper'

RSpec.describe Role do
  describe "Associations" do
    it "should have many users" do
      test_role = Role.reflect_on_association(:users)
      expect(test_role.macro).to eq(:has_and_belongs_to_many)
    end
  end
end