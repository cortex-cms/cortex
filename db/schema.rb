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

ActiveRecord::Schema.define(version: 20131124225601) do

  create_table "assets", force: true do |t|
    t.string   "name",                    limit: 150
    t.integer  "user_id",                             null: false
    t.datetime "deleted_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["user_id"], name: "index_assets_on_user_id"

  create_table "organizations", force: true do |t|
    t.string   "subdomain",     limit: 20,  null: false
    t.string   "name",          limit: 50,  null: false
    t.string   "contact_name",  limit: 50
    t.string   "contact_email", limit: 200
    t.string   "contact_phone", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["name"], name: "index_organizations_on_name", unique: true

  create_table "tenants", force: true do |t|
    t.string   "name",            limit: 50,  null: false
    t.integer  "parent_id"
    t.integer  "organization_id",             null: false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "contact_name",    limit: 50
    t.string   "contact_email",   limit: 200
    t.string   "contact_phone",   limit: 20
    t.datetime "deleted_at"
    t.string   "contract"
    t.string   "did"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenants", ["organization_id"], name: "index_tenants_on_organization_id"
  add_index "tenants", ["parent_id"], name: "index_tenants_on_parent_id"

  create_table "users", force: true do |t|
    t.string   "name",       limit: 50,  null: false
    t.string   "password",   limit: 250, null: false
    t.string   "email",      limit: 200, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
