class ApplyUuidsToCustomContentTables < ActiveRecord::Migration
  def change
    drop_table :content_types
    drop_table :fields
    drop_table :content_items
    drop_table :field_items
    drop_table :decorators
    drop_table :contracts
    drop_table :contentable_decorators

    create_table :content_types, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :name
      t.text :description
      t.integer :creator_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
      t.integer :contract_id
      t.string :icon, default: 'help', null: false
      t.boolean :publishable, default: false

      t.timestamps null: false
    end

    add_index :content_types, :id
    add_index :content_types, :deleted_at

    create_table :fields, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.integer :content_type_id, null: false
      t.string :field_type, null: false
      t.integer :order
      t.boolean :required, default: false, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.jsonb :validations, default: {}
      t.datetime :deleted_at
      t.string :name
      t.jsonb :metadata

      t.timestamps null: false
    end

    add_index :fields, :id
    add_index :fields, :deleted_at

    create_table :content_items, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.integer  :creator_id
      t.integer  :content_type_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
      t.boolean  :is_published, default: false
      t.integer  :updated_by_id
      t.string   :state
      t.datetime :publish_date

      t.timestamps null: false
    end

    add_index :content_items, :id
    add_index :content_items, :deleted_at

    create_table :field_items, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.integer  :field_id
      t.integer  :content_item_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
      t.jsonb    :data, default: {}

      t.timestamps null: false
    end

    add_index :field_items, :id
    add_index :field_items, :field_id
    add_index :field_items, :content_item_id
    add_index :field_items, :deleted_at

    create_table :decorators, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :name
      t.jsonb :data

      t.timestamps null: false
    end

    add_index :decorators, :id

    create_table :contracts, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :name

      t.timestamps null: false
    end

    add_index :contracts, :id

    create_table :contentable_decorators, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.integer :decorator_id
      t.integer :contentable_id
      t.string :contentable_type

      t.timestamps null: false
    end

    add_index :contentable_decorators, :id
    add_index :contentable_decorators, :decorator_id
    add_index :contentable_decorators, :contentable_id
    add_index :contentable_decorators, :contentable_type
  end
end
