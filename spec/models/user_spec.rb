# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:member) {users(:member)}
  let(:admin) {users(:admin)}

  context 'Associations' do
    it 'should be a member' do
      expect(member.has_role?(:member)).to be_truthy
    end
  end

  context 'Users can be activated and deactivated' do
    it 'defaults to activated' do
      expect(member.deactivated?).to be_falsey
      expect(member.activated?).to be_truthy
    end

    it 'can be deactivated' do
      member.deactivate
      expect(member.deactivated?).to be_truthy
      expect(member.activated?).to be_falsey
    end

    it 'can be reactivated' do
      member.activate
      expect(member.deactivated?).to be_falsey
      expect(member.activated?).to be_truthy
    end
  end
end
