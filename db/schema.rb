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

ActiveRecord::Schema.define(version: 20170417185915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "applications", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "write",      default: false
    t.integer  "tenant_id"
    t.index ["tenant_id"], name: "index_applications_on_tenant_id", using: :btree
  end

  create_table "content_items", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "content_type_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "deleted_at"
    t.boolean  "is_published",    default: false
    t.integer  "updated_by_id"
    t.string   "state"
    t.datetime "publish_date"
    t.integer  "creator_id",                      null: false
    t.index ["deleted_at"], name: "index_content_items_on_deleted_at", using: :btree
    t.index ["id"], name: "index_content_items_on_id", using: :btree
  end

  create_table "content_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator_id",                   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.uuid     "contract_id"
    t.string   "icon",        default: "help", null: false
    t.boolean  "publishable", default: false
    t.index ["deleted_at"], name: "index_content_types_on_deleted_at", using: :btree
    t.index ["id"], name: "index_content_types_on_id", using: :btree
  end

  create_table "contentable_decorators", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "decorator_id"
    t.uuid     "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["contentable_id"], name: "index_contentable_decorators_on_contentable_id", using: :btree
    t.index ["contentable_type"], name: "index_contentable_decorators_on_contentable_type", using: :btree
    t.index ["decorator_id"], name: "index_contentable_decorators_on_decorator_id", using: :btree
    t.index ["id"], name: "index_contentable_decorators_on_id", using: :btree
  end

  create_table "contracts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_contracts_on_id", using: :btree
  end

  create_table "decorators", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.jsonb    "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_decorators_on_id", using: :btree
  end

  create_table "field_items", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "field_id"
    t.uuid     "content_item_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.jsonb    "data",            default: {}
    t.index ["content_item_id"], name: "index_field_items_on_content_item_id", using: :btree
    t.index ["deleted_at"], name: "index_field_items_on_deleted_at", using: :btree
    t.index ["field_id"], name: "index_field_items_on_field_id", using: :btree
    t.index ["id"], name: "index_field_items_on_id", using: :btree
  end

  create_table "field_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "content_type_id",                           null: false
    t.string   "field_type",                                null: false
    t.boolean  "required",        default: false,           null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.jsonb    "validations",     default: {}
    t.datetime "deleted_at"
    t.string   "name"
    t.jsonb    "metadata",        default: {"default"=>{}}
    t.index ["deleted_at"], name: "index_fields_on_deleted_at", using: :btree
    t.index ["id"], name: "index_fields_on_id", using: :btree
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string   "key",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true, using: :btree
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string   "feature_key", null: false
    t.string   "key",         null: false
    t.string   "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true, using: :btree
  end

  create_table "locales", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "localization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.index ["id"], name: "index_locales_on_id", using: :btree
    t.index ["localization_id"], name: "index_locales_on_localization_id", using: :btree
    t.index ["user_id"], name: "index_locales_on_user_id", using: :btree
  end

  create_table "localizations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       null: false
    t.index ["id"], name: "index_localizations_on_id", using: :btree
    t.index ["user_id"], name: "index_localizations_on_user_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "scopes",       default: "", null: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "resource_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "tenants", force: :cascade do |t|
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
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["did"], name: "index_tenants_on_did", using: :btree
    t.index ["owner_id"], name: "index_tenants_on_owner_id", using: :btree
    t.index ["parent_id"], name: "index_tenants_on_parent_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["tenant_id"], name: "index_users_on_tenant_id", using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end
