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

ActiveRecord::Schema.define(version: 20130721165917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "corporation_keys", force: true do |t|
    t.string  "v_code"
    t.integer "corporation_id"
  end

  create_table "corporations", force: true do |t|
    t.string   "name"
    t.string   "ticker"
    t.text     "description"
    t.string   "url"
    t.datetime "join_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",                 default: true, null: false
    t.integer  "members_count",          default: 0
    t.integer  "corporation_keys_count", default: 0
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_trackings", force: true do |t|
    t.integer  "member_id"
    t.datetime "logon"
    t.datetime "logoff"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.integer  "corporation_id"
    t.datetime "join_at"
    t.integer  "base_id"
    t.string   "base"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
