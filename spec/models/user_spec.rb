# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe "Associations" do
    it "should have a role" do
      test_user = User.reflect_on_association(:roles)
      expect(test_user.macro).to eq(:has_and_belongs_to_many)
    end

    it 'should be a member' do
      user = User.create!(
        email: "alicia@test.com",
        password: "123abc",
        full_name: "Alicia Barrett",
        street_address: "123 street",
        city: "Atlanta",
        state: "GA",
        postal_code: "30030",
        phone_number: "909-851-9806"
      )

      expect(user.has_role?(:member)).to be_truthy
    end
  end
end
