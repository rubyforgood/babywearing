# frozen_string_literal: true

RSpec.describe Carrier::FilterImpl do
  describe '.with_state_in' do
    context 'with parameter available' do
      it 'returns all and only ones with available state' do
        carrier = carriers(:carrier)
        avail = carriers(:available)
        carriers = Carrier.with_state_in([:available])

        expect(carriers.size).to eq(2)
        expect(carriers.map(&:id)).to match_array([carrier.id, avail.id])
      end
    end
  end
end
