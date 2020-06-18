# frozen_string_literal: true

RSpec.shared_examples 'admin authorized-only resource' do |action|
  subject(:access) { send action.to_sym, endpoint, params: defined?(params) && params || {} }

  it 'authorizes admin users' do
    sign_in users(:admin)
    access

    expect(response).not_to be_unauthorized
  end

  it 'does not authorize member users' do
    sign_in users(:member)
    access

    expect(response).to be_unauthorized
  end

  it 'does not authorize volunteer users' do
    sign_in users(:volunteer)
    access

    expect(response).to be_unauthorized
  end
end

RSpec.shared_examples 'admin and volunteer authorized-only resource' do |action|
  subject(:access) { send action.to_sym, endpoint, params: defined?(params) && params || {} }

  it 'authorizes admin users' do
    sign_in users(:admin)
    access

    expect(response).not_to be_unauthorized
  end

  it 'authorizes volunteer users' do
    sign_in users(:volunteer)
    access

    expect(response).not_to be_unauthorized
  end

  it 'does not authorize member users' do
    sign_in users(:member)
    access

    expect(response).to be_unauthorized
  end
end
