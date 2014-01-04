module Exceptions

  class CortexError < StandardError
  end

  class CortexAPIError < CortexError
    attr_accessor :http_status

    def initialize(message = 'Internal server error', http_status = :internal_server_error)
      @http_status = http_status
      super(message)
    end
  end

  class NotEmptyError < CortexAPIError
    def initialize(message = nil)
      super(message, :conflict)
    end
  end
end
