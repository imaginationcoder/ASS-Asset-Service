module Utilities
  module ErrorHandling
    def render_error_response(status, message, error)
      render status: status, json: { success: false, error: error, message: message}
    end
  end
end
