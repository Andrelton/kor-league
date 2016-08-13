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

ActiveRecord::Schema.define(version: 20160813202144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "fd_id"
    t.string   "fd_name"
    t.string   "name"
    t.string   "crest_url"
    t.integer  "points"
    t.integer  "played"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clubs", ["country_id"], name: "index_clubs_on_country_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.integer  "fd_id"
    t.string   "fd_name"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer  "home_club_id"
    t.integer  "away_club_id"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "owner_clubs", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "owner_clubs", ["club_id"], name: "index_owner_clubs_on_club_id", using: :btree
  add_index "owner_clubs", ["owner_id"], name: "index_owner_clubs_on_owner_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "avatar"
  end

  create_table "pretty_club_names", force: :cascade do |t|
    t.integer  "fd_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "location"
    t.text     "about"
    t.string   "profile_pic"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "clubs", "countries"
end
