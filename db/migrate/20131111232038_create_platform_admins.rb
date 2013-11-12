class CreatePlatformAdmins < ActiveRecord::Migration
  def change
    create_table :platform_admins do |t|
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
