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

ActiveRecord::Schema.define(version: 20170719151020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "difficulties", force: :cascade do |t|
    t.string "rating"
  end

  create_table "event_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_roles_on_event_id"
    t.index ["user_id"], name: "index_event_roles_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "trail_id"
    t.string "name"
    t.string "description"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.boolean "archived", default: false
    t.index ["trail_id"], name: "index_events_on_trail_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "image"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "trails", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "location"
    t.float "distance"
    t.float "rating"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hp_id"
    t.bigint "difficulty_id"
    t.index ["difficulty_id"], name: "index_trails_on_difficulty_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "role"
    t.string "fitbit_token"
    t.string "fitbit_id"
    t.string "image"
  end

  add_foreign_key "event_roles", "events"
  add_foreign_key "event_roles", "users"
  add_foreign_key "events", "trails"
  add_foreign_key "trails", "difficulties"
end
