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

ActiveRecord::Schema.define(version: 20140105120149) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "emails", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.text     "to"
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "public",        default: true
    t.integer  "project_id"
    t.string   "location_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.integer  "position"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "shortcut"
    t.boolean  "public"
    t.integer  "page_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "guestbooks", force: :cascade do |t|
    t.text     "content"
    t.string   "name"
    t.string   "website"
    t.string   "email"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "page_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "birth_name"
    t.string   "street"
    t.string   "city"
    t.string   "phone"
    t.string   "fax"
    t.string   "mobile"
    t.string   "email"
    t.string   "email_extern"
    t.date     "birthday"
    t.date     "member_since"
    t.integer  "school"
    t.string   "gender"
    t.boolean  "active",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.text     "file_meta"
    t.integer  "birth_day"
    t.integer  "birth_month"
  end

  create_table "members_roles", id: false, force: :cascade do |t|
    t.integer "member_id"
    t.integer "role_id"
  end

  add_index "members_roles", ["member_id", "role_id"], name: "index_members_roles_on_member_id_and_role_id"

  create_table "page_files", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "description"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.text     "file_meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
    t.integer  "position"
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "show_in_navigation"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "background_id"
    t.string   "navigation_style"
    t.string   "body_background"
    t.string   "content_background"
    t.string   "path"
  end

  add_index "pages", ["path"], name: "index_pages_on_path", unique: true

  create_table "project_files", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "description"
    t.string   "kind"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.text     "file_meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meta"
    t.integer  "width"
    t.integer  "height"
    t.integer  "position"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
    t.text     "videos"
    t.boolean  "published"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.string   "role"
    t.string   "description"
    t.boolean  "public",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "width"
    t.integer  "height"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.text     "file_meta"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.boolean  "public"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "width"
    t.integer  "height"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.text     "file_meta"
    t.string   "segment"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
