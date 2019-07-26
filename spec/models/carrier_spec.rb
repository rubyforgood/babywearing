require 'rails_helper'

RSpec.describe Carrier, :type => :model do
  it 'is valid with valid attributes' do
    expect(described_class.new(
      item_id: 1,
      name: 'test name',
      manufacturer: 'apple',
      model: 'iCarry',
      color: 'blue',
      location_id: 1
    )).to be_valid
  end

  it 'is not valid without an item_id' do
    expect(described_class.new(item_id: nil)).to_not be_valid
  end

  it 'is not valid without a name' do
    expect(described_class.new(name: nil)).to_not be_valid
  end

  it 'is not valid without a manufacturer' do
    expect(described_class.new(manufacturer: nil)).to_not be_valid
  end

  it 'is not valid without an model' do
    expect(described_class.new(model: nil)).to_not be_valid
  end

  it 'is not valid without a color' do
    expect(described_class.new(color: nil)).to_not be_valid
  end

  it 'is not valid without a location_id' do
    expect(described_class.new(location_id: nil)).to_not be_valid
  end
end