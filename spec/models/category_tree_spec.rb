require 'rails_helper'

RSpec.describe CategoryTree, type: :model do
  context 'with dummy data' do
    let(:data) do
      [{category: "Category"}]
    end

    it 'should add data to the tree' do
      expect(CategoryTree.build(data).find(1).node[:category]).to eq("Category")
    end
  end
end
