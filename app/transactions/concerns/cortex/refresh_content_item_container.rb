module Cortex
  class ParseFieldItems
    include Dry::Transaction::Operation

    def call(input)
      Success(parse_field_items!(input))
    end
  end

  class Persist
    include Dry::Transaction::Operation

    def call(input)
      Success(input.save!)
    end
  end

  class ExecuteStateChange
    include Dry::Transaction::Operation

    def call(input)
      execute_state_change(input)
      Success(input)
    end
  end

  class RefreshContentItemContainer
    extend Dry::Container::Mixin

    namespace "refresh_content_item" do |ops|
      ops.register "parse_field_items" do
        Cortex::ParseFieldItems.new
      end

      ops.register "persist" do
        Cortex::Persist.new
      end

      ops.register "execute_state_change" do
        Cortex::ExecuteStateChange.new
      end
    end
  end
end
