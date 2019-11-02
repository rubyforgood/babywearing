# frozen_string_literal: true

RSpec.describe Category, type: :model do
  let!(:category) { categories(:category) }

  it "is unique" do
    duplicate = described_class.new(name: category.name)
    duplicate.save
    expect(duplicate.errors[:name]).to include "has already been taken"
  end
end
