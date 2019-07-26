require 'rails_helper'

RSpec.describe Organization, :type => :model do
  it "is invalid without name attribute" do
    organization = Organization.new(name: nil, description:'test description')
    expect(organization).to_not be_valid
  end

  it "is valid with required attributes" do
    organization = Organization.new(name: 'organization name', description:'test description')
    expect(organization).to be_valid
  end
end