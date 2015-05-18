class CreateJoinTableSnippets < ActiveRecord::Migration
  def change
    create_join_table :webpages, :documents, table_name: 'snippets' do |t|
      t.column :id, :primary_key
      t.integer :user_id, null: false, index: true
      t.datetime :deleted_at

      t.timestamps null: false

      # t.index [:webpage_id, :document_id]
      # t.index [:document_id, :webpage_id]
    end
  end
end
