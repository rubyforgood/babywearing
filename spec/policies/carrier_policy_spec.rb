# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarrierPolicy do

  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }

  subject(:instance) { described_class }

  permissions :create? do

    it "denies access if user is not an admin or volunteer" do
      expect(subject).not_to permit(member)
    end

    it "grants access if the user is an admin" do
      expect(subject).to permit(admin)
    end

    it "grants access if the user is a volunteer" do
      expect(subject).to permit(volunteer)
    end

  end

  permissions :update? do

    it "denies access if user is not an admin or volunteer" do
      expect(subject).not_to permit(member)
    end

    it "grants access if the user is an admin" do
      expect(subject).to permit(admin)
    end

    it "grants access if the user is a volunteer" do
      expect(subject).to permit(volunteer)
    end

  end

  permissions :destroy? do

    it "denies access if user is not an admin or volunteer" do
      expect(subject).not_to permit(member)
    end

    it "grants access if the user is an admin" do
      expect(subject).to permit(admin)
    end

    it "grants access if the user is a volunteer" do
      expect(subject).to permit(volunteer)
    end

  end
end
