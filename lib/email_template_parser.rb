# frozen_string_literal: true

class EmailTemplateParser
  attr_accessor :due_date, :user_name, :carrier_name

  def initialize(
    user_name:,
    due_date: nil,
    carrier_name: nil
  )
    @user_name = user_name
    @due_date = due_date.to_s
    @carrier_name = carrier_name
  end

  def parse_body(template_body)
    EmailTemplate::PLACEHOLDERS.each_key do |p|
      subvalue = send(p.underscore.delete('%'))
      template_body.gsub!(p, subvalue) if subvalue
    end
    template_body
  end
end
