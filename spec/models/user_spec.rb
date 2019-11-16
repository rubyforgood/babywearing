# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:member) { users(:member) }
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
end
