# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy do
  subject(:instance) { described_class }

  let(:admin_user) do
    user = User.new
    user.add_role(:admin)
    user
  end

  let(:non_admin_or_volunteer_user) do
    user = User.new
    user
  end

  let(:volunteer_user) do
    user = User.new
    user.add_role(:volunteer)
    user
  end

  permissions :index? do
    it "denies access if user is not an admin or volunteer" do
      expect(subject).not_to permit(non_admin_or_volunteer_user)
    end

    it "grants  access if the user is an admin" do
      expect(subject).to permit(admin_user)
    end

    it "grants  access if the user is a volunteer" do
      expect(subject).to permit(volunteer_user)
    end
  end
end
