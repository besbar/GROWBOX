# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_01_113627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_settings", force: :cascade do |t|
    t.text "description"
    t.bigint "sensor_id", null: false
    t.float "temperature_min"
    t.float "temperature_max"
    t.float "air_rh_min"
    t.float "air_rh_max"
    t.integer "tank_level_min"
    t.float "ground_rh_min"
    t.float "ground_rh_max"
    t.float "luminosity_min"
    t.float "luminosity_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_alert_settings_on_sensor_id"
  end

  create_table "alerts", force: :cascade do |t|
    t.boolean "status"
    t.bigint "alert_settings_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_settings_id"], name: "index_alerts_on_alert_settings_id"
  end

  create_table "device_metrics", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.float "temperature"
    t.float "air_rh"
    t.float "ground_rh"
    t.float "luminosity"
    t.integer "tank_level"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_device_metrics_on_device_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.boolean "status", default: false
    t.boolean "temperature", default: false
    t.boolean "air_rh", default: false
    t.boolean "ground_rh", default: false
    t.boolean "luminosity", default: false
    t.boolean "volume", default: false
    t.boolean "tank_level", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subcategory"
  end

  create_table "plant_devices", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.bigint "device_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_plant_devices_on_device_id"
    t.index ["plant_id"], name: "index_plant_devices_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "family"
    t.string "species"
    t.string "site_name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_plants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "company"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alert_settings", "devices", column: "sensor_id"
  add_foreign_key "alerts", "alert_settings", column: "alert_settings_id"
  add_foreign_key "device_metrics", "devices"
  add_foreign_key "plant_devices", "devices"
  add_foreign_key "plant_devices", "plants"
  add_foreign_key "plants", "users"
end
