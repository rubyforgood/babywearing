# frozen_string_literal: true

RSpec.describe Carrier do
  let(:location) { locations(:location) }
  let(:category) { categories(:category) }

  it 'is valid with valid attributes' do
    expect(described_class.new(
      item_id: 1,
      name: 'test name',
      manufacturer: 'apple',
      model: 'iCarry',
      color: 'blue',
      location_id: location.id,
      category_id: category.id
    )).to be_valid
  end

  it "should have a photo attached" do
    carrier = Carrier.new
    file = Rails.root.join('public', 'apple-touch-icon.png')
    carrier.photos.attach(io: File.open(file), filename: 'apple-touch-icon.png')
    assert carrier.photos.attached?
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

  describe '#build_loan' do
    fixtures(:carriers)

    let(:carrier) { described_class.first }

    context "without parameters" do
      subject { carrier.build_loan }

      it 'creates a loan with the default due date set' do
        expect(subject.due_date).to eq Date.today + carrier.default_loan_length_days.days
      end
    end

    context "with parameters" do
      fixtures(:users)

      let(:member)    { users(:user) }
      let(:volunteer) { users(:volunteer) }
      let(:cart)      { Cart.new(member: member, volunteer: volunteer) }

      subject { carrier.build_loan(cart: cart) }

      it 'creates a loan with the default due date set' do
        expect(subject.due_date).to eq Date.today + carrier.default_loan_length_days.days
      end

      it 'honors the additional parameters' do
        expect(subject.cart).to eq cart
      end
    end
  end
end
