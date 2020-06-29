# frozen_string_literal: true

RSpec.describe User::FilterImpl do
  around do |example|
    ActsAsTenant.with_tenant(organizations(:midatlantic)) do
      example.run
    end
  end

  describe '.search_name' do
    context 'with single word parameter' do
      it 'returns matching users' do
        pis = [users(:user), users(:expired)]

        expect(User.search_name('pi')).to match_array(pis)
      end
    end

    context 'with space separated names' do
      it 'returns matching users' do
        expect(User.search_name('admin user')).to match_array([users(:admin), users(:admin2)])
      end
    end
  end

  describe '.with_created_after' do
    context 'with bad date' do
      it 'returns everyone' do
        expect(User.with_created_after('foo')).to match_array(User.all)
      end
    end

    context 'with valid date' do
      it 'returns users created on or after date' do
        expect(User.with_created_after((Time.zone.today - 2.days).to_s)).to match_array(
          [users(:admin2), users(:member)]
        )
      end
    end
  end

  describe '.with_membership_status' do
    context 'with current parameter' do
      it 'calls the with_current_membership scope' do
        expect(User).to receive(:with_current_membership)

        User.with_membership_status('Current')
      end
    end

    context 'with expired parameter' do
      it 'calls the with_expired_membership and with_current_membership scope' do
        expect(User).to receive(:with_expired_membership).and_return(User.all)
        expect(User).to receive(:with_current_membership)

        User.with_membership_status('Expired')
      end
    end

    context 'with none parameter' do
      it 'calls the without_membership scope' do
        expect(User).to receive(:without_membership)

        User.with_membership_status('None')
      end
    end
  end
end
