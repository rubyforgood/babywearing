# frozen_string_literal: true

RSpec.describe EmailTemplate do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:type) }
  end
end
