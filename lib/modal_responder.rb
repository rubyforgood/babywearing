# frozen_string_literal: true

# Custom responder that is used for modals inside the app.
# If you want to render modal call this responder like this
#
#   respond_modal_with @record
#
class ModalResponder < ActionController::Responder
  cattr_accessor :modal_layout
  self.modal_layout = 'modal'

  def render(*args)
    options = args.extract_options!
    options.merge!(layout: modal_layout) if request.xhr?

    controller.render(*args, options)
  end

  def default_render(*args)
    render(*args)
  end

  def redirect_to(options)
    if request.xhr?
      head :ok, location: controller.url_for(options)
    else
      controller.redirect_to(options)
    end
  end
end
