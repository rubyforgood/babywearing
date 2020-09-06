# frozen_string_literal: true

require 'spec_helper'
require 'email_template_parser'

RSpec.describe EmailTemplateParser do
  describe '#parse_body' do
    it 'sets replaces the substitution values' do
      due_date = '03/31/2021'
      carrier_name = 'My Carrier'
      user_name = 'George'
      parser = described_class.new(
        due_date: due_date,
        carrier_name: carrier_name,
        user_name: user_name
      )
      result = parser.parse_body(email_templates(:reminder_one_week).body)

      expect(result).to eq(
        'Hello George,<p>This is to remind you that your My Carrier is due on 03/31/2021.</p> '\
        '<p>Thank you,</p> <p>Midatlantic Babywearing</p>'
      )
    end
  end
end
