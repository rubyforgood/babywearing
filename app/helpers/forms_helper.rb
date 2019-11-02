# frozen_string_literal: true

# View helpers for the forms
module FormsHelper
  # Used to render errors on the forms
  #
  # USAGE
  #   <%= form_errors @record %>
  #
  def form_errors(model)
    render "shared/form_errors", model: model
  end
end
