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

ActiveRecord::Schema.define(version: 20160708062245) do

  create_table "clubs", force: :cascade do |t|
    t.integer  "league_id"
    t.integer  "fd_id"
    t.string   "fd_name"
    t.string   "name"
    t.string   "crest_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clubs", ["league_id"], name: "index_clubs_on_league_id"

  create_table "leagues", force: :cascade do |t|
    t.integer  "fd_id"
    t.string   "fd_name"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
