# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_24_125254) do

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.integer "established_on"
    t.string "hometown"
    t.string "country"
    t.string "color"
    t.string "manager"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "kicked_off_at"
    t.integer "league_id", null: false
    t.integer "home_team_id", null: false
    t.integer "away_team_id", null: false
    t.integer "home_team_score"
    t.integer "away_team_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["league_id"], name: "index_matches_on_league_id"
  end

  add_foreign_key "matches", "clubs", column: "away_team_id"
  add_foreign_key "matches", "clubs", column: "home_team_id"
  add_foreign_key "matches", "leagues"
end
