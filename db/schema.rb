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

ActiveRecord::Schema.define(version: 20180117221543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"
  enable_extension "citext"
  enable_extension "pgcrypto"

  create_table "applications", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "write",      default: false
    t.integer  "tenant_id"
    t.index ["tenant_id"], name: "index_applications_on_tenant_id", using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.string  "firstname"
    t.string  "lastname"
    t.string  "email"
    t.hstore  "sites"
    t.string  "title"
    t.text    "bio"
    t.integer "user_id"
    t.index ["user_id"], name: "index_authors_on_user_id", using: :btree
  end

  create_table "bulk_jobs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "content_type",          null: false
    t.integer  "user_id"
    t.string   "status"
    t.text     "log"
    t.string   "metadata_file_name"
    t.string   "metadata_content_type"
    t.integer  "metadata_file_size"
    t.datetime "metadata_updated_at"
    t.string   "assets_file_name"
    t.string   "assets_content_type"
    t.integer  "assets_file_size"
    t.datetime "assets_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["content_type"], name: "index_bulk_jobs_on_content_type", using: :btree
    t.index ["id"], name: "index_bulk_jobs_on_id", using: :btree
    t.index ["user_id"], name: "index_bulk_jobs_on_user_id", using: :btree
  end

  create_table "carotenes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.citext   "title",      null: false
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_carotenes_on_code", using: :btree
    t.index ["title"], name: "index_carotenes_on_title", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",                null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_posts", id: false, force: :cascade do |t|
    t.integer "post_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "content_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "state"
    t.uuid     "content_type_id", null: false
    t.uuid     "tenant_id",       null: false
    t.uuid     "creator_id",      null: false
    t.uuid     "updated_by_id"
    t.datetime "deleted_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["content_type_id"], name: "index_content_items_on_content_type_id", using: :btree
    t.index ["creator_id"], name: "index_content_items_on_creator_id", using: :btree
    t.index ["deleted_at"], name: "index_content_items_on_deleted_at", using: :btree
    t.index ["state"], name: "index_content_items_on_state", using: :btree
    t.index ["tenant_id"], name: "index_content_items_on_tenant_id", using: :btree
    t.index ["updated_by_id"], name: "index_content_items_on_updated_by_id", using: :btree
  end

  create_table "content_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "name_id",                      null: false
    t.text     "description"
    t.uuid     "creator_id",                   null: false
    t.uuid     "tenant_id",                    null: false
    t.uuid     "contract_id",                  null: false
    t.boolean  "publishable", default: false,  null: false
    t.string   "icon",        default: "help"
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["contract_id"], name: "index_content_types_on_contract_id", using: :btree
    t.index ["creator_id"], name: "index_content_types_on_creator_id", using: :btree
    t.index ["deleted_at"], name: "index_content_types_on_deleted_at", using: :btree
    t.index ["name"], name: "index_content_types_on_name", using: :btree
    t.index ["name_id"], name: "index_content_types_on_name_id", using: :btree
    t.index ["tenant_id"], name: "index_content_types_on_tenant_id", using: :btree
  end

  create_table "contentable_decorators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid     "decorator_id"
    t.string   "contentable_type"
    t.uuid     "contentable_id"
    t.uuid     "tenant_id",        null: false
    t.datetime "deleted_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["contentable_type", "contentable_id"], name: "index_contentable_decorators_on_contentable", using: :btree
    t.index ["decorator_id"], name: "index_contentable_decorators_on_decorator_id", using: :btree
    t.index ["deleted_at"], name: "index_contentable_decorators_on_deleted_at", using: :btree
    t.index ["tenant_id"], name: "index_contentable_decorators_on_tenant_id", using: :btree
  end

  create_table "contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name",       null: false
    t.uuid     "tenant_id",  null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_contracts_on_deleted_at", using: :btree
    t.index ["name"], name: "index_contracts_on_name", using: :btree
    t.index ["tenant_id"], name: "index_contracts_on_tenant_id", using: :btree
  end

  create_table "decorators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name",                    null: false
    t.jsonb    "data",       default: {}, null: false
    t.uuid     "tenant_id",               null: false
    t.datetime "deleted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["deleted_at"], name: "index_decorators_on_deleted_at", using: :btree
    t.index ["name"], name: "index_decorators_on_name", using: :btree
    t.index ["tenant_id"], name: "index_decorators_on_tenant_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name"
    t.text     "body"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_documents_on_user_id", using: :btree
  end

  create_table "field_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb    "data",            default: {}, null: false
    t.uuid     "field_id",                     null: false
    t.uuid     "content_item_id",              null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["content_item_id"], name: "index_field_items_on_content_item_id", using: :btree
    t.index ["data"], name: "index_field_items_on_data", using: :gin
    t.index ["deleted_at"], name: "index_field_items_on_deleted_at", using: :btree
    t.index ["field_id"], name: "index_field_items_on_field_id", using: :btree
  end

  create_table "field_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
  end

  create_table "fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "name_id",                      null: false
    t.string   "field_type",                   null: false
    t.jsonb    "metadata",        default: {}, null: false
    t.jsonb    "validations",     default: {}, null: false
    t.uuid     "content_type_id",              null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["content_type_id"], name: "index_fields_on_content_type_id", using: :btree
    t.index ["deleted_at"], name: "index_fields_on_deleted_at", using: :btree
    t.index ["field_type"], name: "index_fields_on_field_type", using: :btree
    t.index ["name"], name: "index_fields_on_name", using: :btree
    t.index ["name_id"], name: "index_fields_on_name_id", using: :btree
  end

  create_table "flipper_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "key",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true, using: :btree
  end

  create_table "flipper_gates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "feature_key", null: false
    t.string   "key",         null: false
    t.string   "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["feature_key"], name: "index_flipper_gates_on_feature_key", unique: true, using: :btree
    t.index ["key"], name: "index_flipper_gates_on_key", unique: true, using: :btree
    t.index ["value"], name: "index_flipper_gates_on_value", unique: true, using: :btree
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

  create_table "media", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "user_id"
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "dimensions",              limit: 255
    t.text     "description"
    t.string   "alt",                     limit: 255
    t.boolean  "active"
    t.datetime "deactive_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "digest",                  limit: 255
    t.datetime "deleted_at"
    t.hstore   "meta"
    t.string   "type",                    limit: 255, default: "Media", null: false
    t.index ["user_id"], name: "index_media_on_user_id", using: :btree
  end

  create_table "media_posts", id: false, force: :cascade do |t|
    t.integer "post_id",  null: false
    t.integer "media_id", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id",             null: false
    t.integer  "application_id",                null: false
    t.string   "token",             limit: 255, null: false
    t.integer  "expires_in",                    null: false
    t.text     "redirect_uri",                  null: false
    t.datetime "created_at",                    null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255,              null: false
    t.string   "uid",          limit: 255,              null: false
    t.string   "secret",       limit: 255,              null: false
    t.text     "redirect_uri",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type",   limit: 255
    t.string   "scopes",                   default: "", null: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "onet_occupations", force: :cascade do |t|
    t.string   "soc",         limit: 255
    t.string   "title",       limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "onet_occupations_posts", id: false, force: :cascade do |t|
    t.integer "post_id",            null: false
    t.integer "onet_occupation_id", null: false
  end

  create_table "permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.uuid     "resource_id"
    t.datetime "deleted_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["deleted_at"], name: "index_permissions_on_deleted_at", using: :btree
    t.index ["name"], name: "index_permissions_on_name", using: :btree
    t.index ["resource_id"], name: "index_permissions_on_resource_id", using: :btree
    t.index ["resource_type"], name: "index_permissions_on_resource_type", using: :btree
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.uuid "permission_id", null: false
    t.uuid "role_id",       null: false
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
    t.index ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",                                          null: false
    t.string   "title",               limit: 255
    t.datetime "published_at"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.boolean  "draft",                           default: true,   null: false
    t.integer  "comment_count",                   default: 0,      null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_description",   limit: 255
    t.integer  "job_phase",                                        null: false
    t.integer  "display",                                          null: false
    t.text     "notes"
    t.string   "copyright_owner",     limit: 255
    t.string   "seo_title",           limit: 255
    t.string   "seo_description",     limit: 255
    t.string   "seo_preview",         limit: 255
    t.string   "custom_author",       limit: 255
    t.string   "slug",                                             null: false
    t.integer  "featured_media_id"
    t.integer  "primary_industry_id"
    t.integer  "primary_category_id"
    t.integer  "tile_media_id"
    t.hstore   "meta"
    t.string   "type",                            default: "Post", null: false
    t.integer  "author_id"
    t.boolean  "is_wysiwyg",                      default: true
    t.boolean  "noindex",                         default: false
    t.boolean  "nofollow",                        default: false
    t.boolean  "nosnippet",                       default: false
    t.boolean  "noodp",                           default: false
    t.boolean  "noarchive",                       default: false
    t.boolean  "noimageindex",                    default: false
    t.boolean  "is_sticky",                       default: false
    t.uuid     "carotene_id"
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
    t.index ["carotene_id"], name: "index_posts_on_carotene_id", using: :btree
    t.index ["slug"], name: "index_posts_on_slug", using: :btree
    t.index ["type"], name: "index_posts_on_type", using: :btree
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.uuid     "resource_id"
    t.datetime "deleted_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["deleted_at"], name: "index_roles_on_deleted_at", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id", using: :btree
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.uuid "role_id", null: false
    t.uuid "user_id", null: false
    t.index ["role_id"], name: "index_roles_users_on_role_id", using: :btree
    t.index ["user_id"], name: "index_roles_users_on_user_id", using: :btree
  end

  create_table "snippets", force: :cascade do |t|
    t.integer  "webpage_id",  null: false
    t.integer  "document_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_snippets_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
    t.integer "tenant_id",                  default: 1
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "tenants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "name",        limit: 50, null: false
    t.string   "name_id",                null: false
    t.text     "description"
    t.uuid     "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "deleted_at"
    t.datetime "active_at"
    t.datetime "deactive_at"
    t.uuid     "owner_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["deleted_at"], name: "index_tenants_on_deleted_at", using: :btree
    t.index ["name"], name: "index_tenants_on_name", unique: true, using: :btree
    t.index ["name_id"], name: "index_tenants_on_name_id", unique: true, using: :btree
    t.index ["owner_id"], name: "index_tenants_on_owner_id", using: :btree
    t.index ["parent_id"], name: "index_tenants_on_parent_id", using: :btree
  end

  create_table "tenants_users", id: false, force: :cascade do |t|
    t.uuid "tenant_id", null: false
    t.uuid "user_id",   null: false
    t.index ["tenant_id"], name: "index_tenants_users_on_tenant_id", using: :btree
    t.index ["user_id"], name: "index_tenants_users_on_user_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string   "email",                             default: "",      null: false
    t.string   "firstname",                                           null: false
    t.string   "lastname",                                            null: false
    t.string   "locale",                 limit: 30, default: "en_US", null: false
    t.string   "timezone",               limit: 30, default: "EST",   null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.uuid     "active_tenant_id"
    t.string   "encrypted_password",                default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["active_tenant_id"], name: "index_users_on_active_tenant_id", using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "webpages", force: :cascade do |t|
    t.integer  "user_id",                                null: false
    t.string   "name"
    t.citext   "url"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "seo_title"
    t.text     "seo_description"
    t.boolean  "noindex",                default: false
    t.boolean  "nofollow",               default: false
    t.boolean  "nosnippet",              default: false
    t.boolean  "noodp",                  default: false
    t.boolean  "noarchive",              default: false
    t.boolean  "noimageindex",           default: false
    t.text     "seo_keywords"
    t.jsonb    "tables_widget"
    t.jsonb    "charts_widget"
    t.jsonb    "accordion_group_widget"
    t.jsonb    "buy_box_widget"
    t.jsonb    "carousels_widget"
    t.jsonb    "galleries_widget"
    t.jsonb    "form_configs"
    t.jsonb    "product_data"
    t.jsonb    "card_group_widget"
    t.index ["user_id"], name: "index_webpages_on_user_id", using: :btree
  end

  add_foreign_key "content_items", "content_types"
  add_foreign_key "content_items", "tenants"
  add_foreign_key "content_items", "users", column: "creator_id"
  add_foreign_key "content_items", "users", column: "updated_by_id"
  add_foreign_key "content_types", "contracts"
  add_foreign_key "content_types", "tenants"
  add_foreign_key "content_types", "users", column: "creator_id"
  add_foreign_key "contentable_decorators", "decorators"
  add_foreign_key "contentable_decorators", "tenants"
  add_foreign_key "contracts", "tenants"
  add_foreign_key "decorators", "tenants"
  add_foreign_key "field_items", "content_items"
  add_foreign_key "field_items", "fields"
  add_foreign_key "fields", "content_types"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "posts", "carotenes"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "tenants", "users", column: "owner_id"
  add_foreign_key "tenants_users", "tenants"
  add_foreign_key "tenants_users", "users"
  add_foreign_key "users", "tenants", column: "active_tenant_id"
end
