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

ActiveRecord::Schema[7.1].define(version: 2025_03_12_115629) do
  create_table "infos", force: :cascade do |t|
    t.text "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifier"
    t.string "hunter"
    t.string "location"
    t.date "Hunteddate"
    t.float "latitude"
    t.float "longitude"
    t.string "method"
    t.string "ages"
    t.string "sex"
    t.string "weight"
    t.date "butchering_date"
    t.string "processed_location"
    t.date "processed_date"
    t.string "processed_by"
    t.string "species"
    t.string "access_token"
  end

end
