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

ActiveRecord::Schema.define(version: 20131222062432) do

  create_table "activities", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "source"
    t.integer  "project_id"
    t.string   "url"
    t.string   "icon_url"
    t.string   "status"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "api_key",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["api_key"], name: "index_projects_on_api_key", unique: true
  add_index "projects", ["provider"], name: "index_projects_on_provider"

  create_table "user_projects", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.integer  "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "token"
    t.integer  "dashbozu_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["nickname"], name: "index_users_on_nickname"
  add_index "users", ["provider"], name: "index_users_on_provider"

end
