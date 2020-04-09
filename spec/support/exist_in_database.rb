# frozen_string_literal: true

RSpec::Matchers.define :exist_in_database do
  match do |actual|
    actual.class.exists?(actual.id)
  end
end
