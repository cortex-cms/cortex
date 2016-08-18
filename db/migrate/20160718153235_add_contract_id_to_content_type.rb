class AddContractIdToContentType < ActiveRecord::Migration
  def change
    add_column :content_types, :contract_id, :integer
  end
end
