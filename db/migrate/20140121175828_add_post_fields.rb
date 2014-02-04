class AddPostFields < ActiveRecord::Migration
  def change
    Post.destroy_all

    add_column :posts, :short_description, :string
    add_column :posts, :job_phase, :integer, null: false
    add_column :posts, :display, :integer, null: false
    add_column :posts, :featured_image_url, :string
    add_column :posts, :notes, :text
    add_column :posts, :copyright_owner, :string
    add_column :posts, :seo_title, :string
    add_column :posts, :seo_description, :string
    add_column :posts, :seo_preview, :string

    remove_column :posts, :type
    add_column :posts, :type, :integer, null: false
  end

  def down
    remove_column :posts, :short_description, :string
    remove_column :posts, :job_phase, :integer
    remove_column :posts, :display, :integer
    remove_column :posts, :featured_image_url, :string
    remove_column :posts, :notes, :text
    remove_column :posts, :copyright_owner, :string
    remove_column :posts, :seo_title, :string
    remove_column :posts, :seo_description, :string
    remove_column :posts, :seo_preview, :string

    remove_column :posts, :type
    add_column :posts, :type, :string
  end
end
