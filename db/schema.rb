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

ActiveRecord::Schema.define(version: 2021_01_01_224631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "happening_templates", force: :cascade do |t|
    t.string "kind"
    t.string "description"
    t.integer "point_value"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.string "name"
    t.boolean "show_success_button", default: true
    t.boolean "show_pass_button", default: false
    t.boolean "show_fail_button", default: false
    t.integer "allowed_entries_daily_count"
    t.index ["user_id"], name: "index_happening_templates_on_user_id"
  end

  create_table "happening_templates_users", force: :cascade do |t|
    t.bigint "happening_template_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["happening_template_id"], name: "index_happening_templates_users_on_happening_template_id"
    t.index ["user_id"], name: "index_happening_templates_users_on_user_id"
  end

  create_table "happenings", force: :cascade do |t|
    t.string "description"
    t.integer "point_value"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reporting_user_id"
    t.string "name"
    t.string "event_kind"
    t.string "template_kind"
    t.bigint "happening_template_id"
    t.index ["happening_template_id"], name: "index_happenings_on_happening_template_id"
    t.index ["reporting_user_id"], name: "index_happenings_on_reporting_user_id"
    t.index ["user_id"], name: "index_happenings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
