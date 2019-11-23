# frozen_string_literal: true

RSpec.describe AgreementPolicy do
  subject { described_class }

  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }

  %i[create? update? destroy?].each do |activity|
    permissions activity do
      it { is_expected.not_to permit(member) }
      it { is_expected.to permit(admin, volunteer) }
    end
  end
end
