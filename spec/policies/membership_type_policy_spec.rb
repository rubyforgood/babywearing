# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MembershipTypePolicy do
  subject { described_class }

  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:borrower) { users(:borrower) }

  %i[create? index? update? edit? destroy?].each do |activity|
    permissions activity do
      it { is_expected.not_to permit(borrower, volunteer) }
      it { is_expected.to permit(admin, volunteer) }
    end
  end
end
