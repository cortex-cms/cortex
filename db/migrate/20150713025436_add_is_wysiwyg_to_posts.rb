class AddIsWysiwygToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.boolean :is_wysiwyg, default: true
    end
  end
end
