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

ActiveRecord::Schema.define(version: 20160219215802) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "calendar_events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.text     "content",    limit: 65535
    t.text     "to",         limit: 65535
    t.string   "state",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "public",                      default: true
    t.integer  "project_id",    limit: 4
    t.string   "location_name", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "location_id",   limit: 4
  end

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "member_id",  limit: 4
    t.integer  "position",   limit: 4
    t.string   "role",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "shortcut",    limit: 255
    t.boolean  "public"
    t.integer  "page_id",     limit: 4
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "category",    limit: 255
  end

  create_table "guestbooks", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.string   "name",       limit: 255
    t.string   "website",    limit: 255
    t.string   "email",      limit: 255
    t.integer  "project_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address",    limit: 255
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
    t.integer  "page_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   limit: 4
  end

  create_table "members", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "first_name",        limit: 255
    t.string   "birth_name",        limit: 255
    t.string   "street",            limit: 255
    t.string   "city",              limit: 255
    t.string   "phone",             limit: 255
    t.string   "fax",               limit: 255
    t.string   "mobile",            limit: 255
    t.string   "email",             limit: 255
    t.string   "email_extern",      limit: 255
    t.date     "birthday"
    t.date     "member_since"
    t.integer  "school",            limit: 4
    t.string   "gender",            limit: 255
    t.boolean  "active",                          default: true
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  limit: 255
    t.text     "file_meta",         limit: 65535
    t.integer  "birth_day",         limit: 4
    t.integer  "birth_month",       limit: 4
  end

  create_table "members_roles", id: false, force: :cascade do |t|
    t.integer "member_id", limit: 4
    t.integer "role_id",   limit: 4
  end

  add_index "members_roles", ["member_id", "role_id"], name: "index_members_roles_on_member_id_and_role_id", using: :btree

  create_table "page_files", force: :cascade do |t|
    t.integer  "page_id",           limit: 4
    t.string   "description",       limit: 255
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  limit: 255
    t.text     "file_meta",         limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.integer  "position",          limit: 4
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "parent_id",          limit: 4
    t.string   "title",              limit: 255
    t.text     "content",            limit: 65535
    t.boolean  "show_in_navigation"
    t.boolean  "public"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "position",           limit: 4
    t.integer  "background_id",      limit: 4
    t.string   "navigation_style",   limit: 255
    t.string   "body_background",    limit: 255
    t.string   "content_background", limit: 255
    t.string   "path",               limit: 255
  end

  add_index "pages", ["path"], name: "index_pages_on_path", unique: true, using: :btree

  create_table "project_files", force: :cascade do |t|
    t.integer  "project_id",        limit: 4
    t.string   "description",       limit: 255
    t.string   "kind",              limit: 255
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  limit: 255
    t.text     "file_meta",         limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "meta",              limit: 65535
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.integer  "position",          limit: 4
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "subtitle",    limit: 255
    t.text     "videos",      limit: 65535
    t.boolean  "published"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "team_memberships", force: :cascade do |t|
    t.integer  "team_id",           limit: 4
    t.integer  "member_id",         limit: 4
    t.string   "role",              limit: 255
    t.string   "description",       limit: 255
    t.boolean  "public",                          default: true
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "position",          limit: 4
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  limit: 255
    t.text     "file_meta",         limit: 65535
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.boolean  "public"
    t.integer  "project_id",        limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "position",          limit: 4
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  limit: 255
    t.text     "file_meta",         limit: 65535
    t.string   "segment",           limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.integer  "member_id",              limit: 4
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
