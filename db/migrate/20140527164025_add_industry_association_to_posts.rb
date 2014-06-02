class AddIndustryAssociationToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :industry_id, :integer, index: true
  end
end
