# frozen_string_literal: true

RSpec.describe Carrier::FilterImpl do
  around do |example|
    ActsAsTenant.with_tenant(organizations(:midatlantic)) do
      example.run
    end
  end

  describe '.with_state_in' do
    context 'with parameter available' do
      it 'returns all and only ones with available state' do
        carriers = [carriers(:carrier), carriers(:carrier_4), carriers(:carrier_5),
                    carriers(:available)]
        carriers_found = Carrier.with_state_in([:available])

        expect(carriers_found.size).to eq(carriers.size)
        expect(carriers_found).to match_array(carriers)
      end
    end
  end
end
