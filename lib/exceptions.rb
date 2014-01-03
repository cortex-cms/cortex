module Exceptions

  class CortexError < StandardError
  end

  class CortexAPIError < CortexError
    attr_accessor :http_status

    def initialize(message = nil, http_status = nil)
      self.http_status = http_status || :internal_server_error;
      message = message || 'Internal server error'
      super(message)
    end
  end

  class NotEmptyError < CortexAPIError
    def initialize(message='Internal server error')
      super(message: message, http_status: :conflict)
    end
  end
end
