class AddContractIdToContentType < ActiveRecord::Migration[5.1]
  def change
    add_reference :content_types, :contract, type: :uuid, foreign_key: true
  end
end
