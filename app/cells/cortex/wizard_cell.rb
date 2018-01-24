module Cortex
  class WizardCell < Cortex::ApplicationCell
    property :data

    def show
      render
    end

    private

    def data_mash
      Hashie::Mash.new(data)
    end
  end
end
