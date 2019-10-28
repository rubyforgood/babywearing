# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPolicy do
  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }

  subject { described_class }

  permissions :create? do
    it "denies access if user is not an admin or volunteer" do
      is_expected.not_to permit(member)
    end

    it "grants access if the user is an admin" do
      is_expected.to permit(admin)
    end

    it "grants access if the user is a volunteer" do
      is_expected.to permit(volunteer)
    end
  end

  permissions :update? do
    it "denies access if user is not an admin or volunteer" do
      is_expected.not_to permit(member)
    end

    it "grants access if the user is an admin" do
      is_expected.to permit(admin)
    end

    it "grants access if the user is a volunteer" do
      is_expected.to permit(volunteer)
    end
  end

  permissions :destroy? do
    it "denies access if user is not an admin or volunteer" do
      is_expected.not_to permit(member)
    end

    it "grants access if the user is an admin" do
      is_expected.to permit(admin)
    end

    it "grants access if the user is a volunteer" do
      is_expected.to permit(volunteer)
    end
  end
end
