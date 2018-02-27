require 'securerandom'

class TreeBuilder
  attr_accessor :target_node
  attr_reader :head, :tree_fields

  def initialize
    @head = Hashr.new children: []
    @tree_fields = {}
    @target_node = @head
  end

  def self.generate_id
    SecureRandom.hex 6
  end

  def self.node value
    Hashr.new name: value, value: value.downcase, children: []
  end

  def find_node node_value
    target_node.children.each do |id|
      if tree_fields[id].value == node_value || tree_fields[id].name == node_value
        @target_node = tree_fields[id]
      end
    end
    self
  end

  def add_value value
    field_id = TreeBuilder.generate_id
    tree_fields[field_id] = TreeBuilder.node value
    @target_node.children << field_id
    @target_node = head
  end

  def tree_fields_hash
    @tree_fields_hash ||= tree_fields.keys.inject({}) do |lookup, field_key|
      lookup[field_key] = tree_fields[field_key].to_h
      lookup
    end
  end

  def tree_data
    {
      head: head[:children],
      tree_fields: tree_fields_hash,
      data: tree_fields_hash
    }
  end
end
