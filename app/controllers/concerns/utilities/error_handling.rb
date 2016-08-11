module Utilities
  module ErrorHandling
    def render_error_response(status, message, error)
      render status: status, json: { status: status, success: false, error: error, message: message}
    end
  end
end
