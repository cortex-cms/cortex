module Cortex
  module HasFirstnameLastname
    extend ActiveSupport::Concern

    included do
      def fullname
        lastname.to_s == '' ? firstname : "#{firstname} #{lastname}"
      end
    end
  end
end
