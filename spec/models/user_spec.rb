# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:member) { users(:member) }
  let(:upcoming) { users(:upcoming) }
  let(:nonmember) { users(:nonmember) }
  let(:expired) { users(:expired) }
  let(:admin) { users(:admin) }

  context 'when users can be activated' do
    it 'defaults to activated' do
      expect(member).not_to be_deactivated
      expect(member).to be_activated
    end
  end

  context 'when users can be reactivated' do
    it 'can be reactivated' do
      member.activate

      expect(member).not_to be_deactivated
      expect(member).to be_activated
    end
  end

  context 'when users can be deactivated' do
    it 'can be deactivated' do
      member.deactivate

      expect(member).to be_deactivated
      expect(member).not_to be_activated
    end
  end

  describe "#name_with_membership type" do
    context "with no membership" do
      it "just returns the name" do
        nonmember = users(:nonmember)

        expect(nonmember.name_with_membership).to eq(nonmember.name.full)
      end
    end

    context "with current membership" do
      it "returns the full name with the membership type short name" do
        expect(member.name_with_membership).to eq("Member Bember - AN")
      end
    end

    context "with expired membership" do
      it "returns the full name with the membership type short name indicating expired" do
        expired = users(:expired)

        expect(expired.name_with_membership).to eq("Expired Bember - AN (Expired)")
      end
    end
  end

  describe "#current_membership" do
    context "with no membership" do
      it "is nil" do
        expect(nonmember.current_membership).to be_nil
      end
    end

    context "with an expired membership" do
      it "is nil" do
        expect(expired.current_membership).to be_nil
      end
    end

    context "with current membership" do
      it "returns the membership" do
        expect(member.current_membership).to eq(memberships(:member))
      end
    end

    context "with upcoming membership" do
      it "is nil" do
        expect(upcoming.current_membership).to be_nil
      end
    end
  end
end
