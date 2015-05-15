class CreateJoinTableWebpagesDocuments < ActiveRecord::Migration
  def change
    create_join_table :webpages, :documents do |t|
      # t.index [:webpage_id, :document_id]
      # t.index [:document_id, :webpage_id]
    end
  end
end
