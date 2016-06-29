require 'spec_helper'

describe Tree, :type => :model do
  describe '::recursive_search' do
    let (:tree_array) { [ { name: 'parent_1', id: 1, children: [ { name: 'child_1', id: 3, children: [ { name: 'grandchild_1', id: 5, children: []} ]}, { name: 'child_2', id: 4, children: []} ]}, { name: 'parent_2', id: 2, children: []} ] }

    it 'should return an Array' do
      expect(Tree.gather_ids(tree_array)).to be_a_kind_of(Array)
    end

    it 'should include all the ids from the given Array' do
      expect(Tree.gather_ids(tree_array)).to include(1)
      expect(Tree.gather_ids(tree_array)).to include(2)
      expect(Tree.gather_ids(tree_array)).to include(3)
      expect(Tree.gather_ids(tree_array)).to include(4)
      expect(Tree.gather_ids(tree_array)).to include(5)
    end
  end
end

# Tree Array - For Reference
#
# [
#   { name: 'parent_1', id: 1, children: [
#       { name: 'child_1', id: 3, children: [
#         { name: 'grandchild_1', id: 5, children: []}
#         ]},
#       { name: 'child_2', id: 4, children: []}
#     ]},
#   { name: 'parent_2', id: 2, children: []}
# ]
