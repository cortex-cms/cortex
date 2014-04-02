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

ActiveRecord::Schema.define(version: 20140402155854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "media", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "dimensions"
    t.text     "description"
    t.string   "alt"
    t.boolean  "active"
    t.datetime "deactive_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "digest",                  null: false
    t.datetime "deleted_at"
  end

  add_index "media", ["user_id"], name: "index_media_on_user_id", using: :btree

  create_table "media_posts", id: false, force: true do |t|
    t.integer "post_id",  null: false
    t.integer "media_id", null: false
  end

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id",                           null: false
    t.string   "title"
    t.datetime "published_at"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.boolean  "draft",              default: true, null: false
    t.integer  "comment_count",      default: 0,    null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_description"
    t.integer  "job_phase",                         null: false
    t.integer  "display",                           null: false
    t.string   "featured_image_url"
    t.text     "notes"
    t.string   "copyright_owner"
    t.string   "seo_title"
    t.string   "seo_description"
    t.string   "seo_preview"
    t.integer  "type",                              null: false
    t.string   "author"
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

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenants", ["parent_id"], name: "index_tenants_on_parent_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenant_id",                                           null: false
    t.string   "encrypted_password",                default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "firstname",                                           null: false
    t.string   "lastname"
    t.string   "locale",                 limit: 30, default: "en_US", null: false
    t.string   "timezone",               limit: 30, default: "EST",   null: false
    t.boolean  "admin",                             default: false,   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["tenant_id"], name: "index_users_on_tenant_id", using: :btree

end
