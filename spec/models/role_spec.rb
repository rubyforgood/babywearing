# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role do
  describe "Associations" do
    it "has many users" do
      test_role = described_class.reflect_on_association(:users)
      expect(test_role.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
