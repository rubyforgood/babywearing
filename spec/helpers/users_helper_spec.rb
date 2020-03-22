# frozen_string_literal: true

RSpec.describe UsersHelper do
  let(:member) { users(:member) }
  let(:nonmember) { users(:nonmember) }
  let(:expired) { users(:expired) }
  let(:blocked) { users(:blocked) }

  describe "#user_roles_select" do
    it "returns user roles formated for rails select" do
      result = helper.user_roles_select
      expect(result).to eq [%w[Admin admin], %w[Volunteer volunteer], %w[Member member]]
    end
  end

  describe "#membership_status" do
    context "with no membership" do
      it 'is none' do
        expect(helper.membership_status(nonmember)).to eq('No Membership')
      end
    end

    context "with an expired membership" do
      it "is expired" do
        expect(helper.membership_status(expired)).to eq("Expired")
      end

      it "is not expired when there is also a current one" do
        expired.memberships.create(membership_type_id: membership_types(:annual).id, effective: Time.zone.today - 1.day,
                                   expiration: Time.zone.today + 1.year)

        expect(helper.membership_status(expired)).to eq("Current")
      end
    end

    context "with only a current membership" do
      it "is current" do
        expect(helper.membership_status(member)).to eq("Current")
      end
    end

    context "with a blocked current membership" do
      it "is blocked" do
        expect(helper.membership_status(blocked)).to eq("Blocked")
      end
    end
  end
end
