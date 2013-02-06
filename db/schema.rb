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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130206124812) do

  create_table "appointments", :force => true do |t|
    t.string   "name"
    t.datetime "date_from"
    t.datetime "date_to"
    t.boolean  "public"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "project_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "shortcut"
    t.boolean  "public"
    t.integer  "page_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "show_in_navigation"
    t.integer  "order"
    t.boolean  "public"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "project_files", :force => true do |t|
    t.integer  "project_id"
    t.string   "description"
    t.string   "kind"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.text     "file_meta"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "meta"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "subtitle"
  end

end
