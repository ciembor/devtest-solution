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

ActiveRecord::Schema.define(version: 20160412024155) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "country_code"
    t.integer  "panel_provider_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "countries_target_groups", id: false, force: :cascade do |t|
    t.integer "country_id",      null: false
    t.integer "target_group_id", null: false
  end

  add_index "countries_target_groups", ["country_id", "target_group_id"], name: "country_target_group_index"
  add_index "countries_target_groups", ["target_group_id", "country_id"], name: "target_group_country_index"

  create_table "location_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.integer  "panel_provider_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "location_groups_locations", id: false, force: :cascade do |t|
    t.integer "location_id",       null: false
    t.integer "location_group_id", null: false
  end

  add_index "location_groups_locations", ["location_group_id", "location_id"], name: "location_group_location_index"
  add_index "location_groups_locations", ["location_id", "location_group_id"], name: "location_location_group_index"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "external_id"
    t.string   "secret_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "secret_code"
    t.integer  "external_id"
    t.integer  "parent_id"
    t.integer  "panel_provider_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
