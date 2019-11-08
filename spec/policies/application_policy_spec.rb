# frozen_string_literal: true

## setup for testing abstract-ish application policy
class DummyPundit
  def self.all
    [1, 2, 3]
  end
end

class DummyPunditPolicy < ApplicationPolicy
end
###

RSpec.describe ApplicationPolicy do
  subject(:policy) { described_class }

  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }

  permissions :create?, :destroy?, :edit?, :index?, :new?, :show?, :update? do
    it "denies access" do
      expect(policy).not_to permit(admin)
      expect(policy).not_to permit(volunteer)
      expect(policy).not_to permit(member)
    end
  end

  describe "Scope" do
    let(:scope_admin) { Pundit.policy_scope!(admin, DummyPundit) }
    let(:scope_volunteer) { Pundit.policy_scope!(admin, DummyPundit) }
    let(:scope_member) { Pundit.policy_scope!(admin, DummyPundit) }

    it "allows all" do
      expect(scope_admin.to_a).to match_array([1, 2, 3])
      expect(scope_volunteer.to_a).to match_array([1, 2, 3])
      expect(scope_member.to_a).to match_array([1, 2, 3])
    end
  end
end
