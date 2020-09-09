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

ActiveRecord::Schema.define(version: 2020_09_08_212215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.string "room_name"
    t.string "status"
    t.integer "red_user_id"
    t.string "red_user_name"
    t.json "red_team"
    t.integer "red_active_pokemon"
    t.integer "blue_user_id"
    t.string "blue_user_name"
    t.json "blue_team"
    t.integer "blue_active_pokemon"
    t.string "turn"
    t.string "message"
    t.integer "winner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.integer "power"
    t.integer "priority"
    t.string "types"
    t.integer "accuracy"
    t.string "damage"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "species"
    t.string "types", array: true
    t.json "sprites"
    t.json "stats"
    t.string "moves", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_pokemon_moves", force: :cascade do |t|
    t.bigint "team_pokemon_id", null: false
    t.bigint "move_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["move_id"], name: "index_team_pokemon_moves_on_move_id"
    t.index ["team_pokemon_id"], name: "index_team_pokemon_moves_on_team_pokemon_id"
  end

  create_table "team_pokemons", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "pokemon_id", null: false
    t.string "nickname"
    t.boolean "shiny", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pokemon_id"], name: "index_team_pokemons_on_pokemon_id"
    t.index ["team_id"], name: "index_team_pokemons_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "matches", default: 0
    t.integer "wins", default: 0
    t.integer "losses", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "user_battles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "battle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["battle_id"], name: "index_user_battles_on_battle_id"
    t.index ["user_id"], name: "index_user_battles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.boolean "active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "team_pokemon_moves", "moves"
  add_foreign_key "team_pokemon_moves", "team_pokemons"
  add_foreign_key "team_pokemons", "pokemons"
  add_foreign_key "team_pokemons", "teams"
  add_foreign_key "teams", "users"
  add_foreign_key "user_battles", "battles"
  add_foreign_key "user_battles", "users"
end
