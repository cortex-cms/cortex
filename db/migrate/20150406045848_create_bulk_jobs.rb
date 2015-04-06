class CreateBulkJobs < ActiveRecord::Migration
  def change
    create_table :bulk_jobs, :id => false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :content_type, :null => false
      t.belongs_to :user
      t.string :status
      t.text :log
      t.attachment :metadata
      t.attachment :assets

      t.timestamps null: false
    end

    add_index :bulk_jobs, :id
    add_index :bulk_jobs, :content_type
    add_index :bulk_jobs, :user_id
  end
end
