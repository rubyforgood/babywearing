# frozen_string_literal: true

RSpec.describe CarriersHelper do
  describe "#carrier_badge_class" do
    it "returns correct css class base on the carrier status" do
      expect(helper.carrier_badge_class(carriers(:carrier))).to eq "badge badge-success"
      expect(helper.carrier_badge_class(carriers(:unavailable))).to eq "badge badge-danger"
    end
  end
end
