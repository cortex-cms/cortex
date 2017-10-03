class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name, index: true
      t.references :resource, type: :uuid, polymorphic: true, index: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end

    create_join_table :roles, :users, column_options: { type: :uuid, index: true }
    add_foreign_key :roles_users, :roles, type: :uuid
    add_foreign_key :roles_users, :users, type: :uuid
  end
end
