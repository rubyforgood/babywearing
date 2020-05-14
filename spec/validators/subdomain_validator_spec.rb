# frozen_string_literal: true

require 'rails_helper'
require 'subdomain_validator'

class Subdomain
  include ActiveModel::Model
  attr_accessor :subdomain

  validates :subdomain, subdomain: true
end

RSpec.describe SubdomainValidator, type: :validator do
  it 'validates if the value is not present' do
    subdomain = Subdomain.new(subdomain: nil)
    expect(subdomain).to be_valid
  end

  it 'does not validate subdomains with reserved names' do
    %w[www ftp mail pop smtp ssl sftp].each do |reserved_name|
      subdomain = Subdomain.new(subdomain: reserved_name)
      expect(subdomain).not_to be_valid
    end
  end

  it 'does not validate subdomains when the length is not between 3 and 63 letters' do
    short_subdomain = Subdomain.new(subdomain: 'ww')
    expect(short_subdomain).not_to be_valid

    long_subdomain = Subdomain.new(subdomain: 'a' * 64)
    expect(long_subdomain).not_to be_valid

    valid_length_subdomain = Subdomain.new(subdomain: 'a' * 55)
    expect(valid_length_subdomain).to be_valid
  end

  it 'does not validate subdomains when they start or end with a hyphen' do
    hyphen_prefixed_subdomain = Subdomain.new(subdomain: '-hello')
    expect(hyphen_prefixed_subdomain).not_to be_valid

    hyphen_suffixed_subdomain = Subdomain.new(subdomain: 'bye-')
    expect(hyphen_suffixed_subdomain).not_to be_valid

    hyphened_subdomain = Subdomain.new(subdomain: 'hello-world')
    expect(hyphened_subdomain).to be_valid
  end

  it 'does not validate if the subdomain is not alphanumeric' do
    non_alphanumeric_subdomain = Subdomain.new(subdomain: '_!3482asdkjas')
    expect(non_alphanumeric_subdomain).not_to be_valid
  end
end
