RSpec.describe Organization, :type => :model do
  subject { 
    described_class.new(name: 'name of organization', description: 'test description') 
  }

  it "is valid with required attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without name attribute" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
