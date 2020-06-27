# frozen_string_literal: true

# View helpers for the forms
module FormsHelper
  # Used to render errors on the forms
  #
  # USAGE
  #   <%= form_errors @record %>
  #
  def form_errors(model)
    render 'shared/form_errors', model: model
  end

  def number_to_word(num)
    conversion = {
      10 => 'ten',
      9 => 'nine',
      8 => 'eight',
      7 => 'seven',
      6 => 'six',
      5 => 'five',
      4 => 'four',
      3 => 'three',
      2 => 'two',
      1 => 'one'
    }
    conversion[num] || num.to_s
  end
end
