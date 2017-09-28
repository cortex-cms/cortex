class AddContractIdToContentType < ActiveRecord::Migration[5.1]
  def change
    add_column :content_types, :contract_id, :integer
  end
end
