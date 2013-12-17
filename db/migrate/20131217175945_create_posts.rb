class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false, index: true
      t.string :title
      t.string :type
      t.datetime :published_at
      t.datetime :expired_at
      t.datetime :deleted_at
      t.boolean :draft, null: false, default: true
      t.integer :comment_count, null: false, default: 0
      t.text :body

      t.timestamps
    end
  end
end
