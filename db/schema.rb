# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131217192026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "dimensions"
    t.text     "description"
    t.datetime "deactive_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["user_id"], name: "index_assets_on_user_id", using: :btree

  create_table "assets_posts", id: false, force: true do |t|
    t.integer "post_id",  null: false
    t.integer "asset_id", null: false
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "user_id",    null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_posts", id: false, force: true do |t|
    t.integer "post_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id",                      null: false
    t.string   "title"
    t.string   "type"
    t.datetime "published_at"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.boolean  "draft",         default: true, null: false
    t.integer  "comment_count", default: 0,    null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tenants", force: true do |t|
    t.string   "name",          limit: 50,  null: false
    t.string   "subdomain",     limit: 50
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "contact_name",  limit: 50
    t.string   "contact_email", limit: 200
    t.string   "contact_phone", limit: 20
    t.datetime "deleted_at"
    t.string   "contract"
    t.string   "did"
    t.datetime "active_at"
    t.datetime "deactive_at"
    t.integer  "user_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenants", ["parent_id"], name: "index_tenants_on_parent_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",            limit: 30, null: false
    t.string   "email",                      null: false
    t.string   "password_digest",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
