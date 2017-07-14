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

ActiveRecord::Schema.define(version: 20170714230051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_guests", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "guest_id"
    t.index ["event_id"], name: "index_event_guests_on_event_id"
    t.index ["guest_id"], name: "index_event_guests_on_guest_id"
  end

  create_table "event_hosts", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "host_id"
    t.index ["event_id"], name: "index_event_hosts_on_event_id"
    t.index ["host_id"], name: "index_event_hosts_on_host_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "trail_id"
    t.string "name"
    t.string "description"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "difficulty"
    t.string "location"
    t.float "distance"
    t.float "rating"
    t.float "long"
    t.float "lat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "role"
  end

  add_foreign_key "event_guests", "events"
  add_foreign_key "event_hosts", "events"
  add_foreign_key "events", "trails"
end
