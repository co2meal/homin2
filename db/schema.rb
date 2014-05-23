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

ActiveRecord::Schema.define(version: 20140514122916) do

  create_table "lectures", force: true do |t|
    t.string   "lid"
    t.string   "name"
    t.string   "time"
    t.float    "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sugangs", force: true do |t|
    t.integer  "user_id"
    t.integer  "lecture_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetable", force: true do |t|
    t.string   "sid"
    t.string   "tid"
    t.string   "name"
    t.string   "lecture"
    t.string   "totcredit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sid"
  end

end
