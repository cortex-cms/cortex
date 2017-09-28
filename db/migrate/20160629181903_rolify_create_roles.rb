class RolifyCreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name
      t.references :resource, type: :uuid, polymorphic: true

      t.timestamps null: false
    end

    create_table :users_roles, id: false do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :role, type: :uuid, foreign_key: true

      t.timestamps null: false
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
  end
end
