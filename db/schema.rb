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

ActiveRecord::Schema.define(version: 20160809023934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "board_space_messages", force: :cascade do |t|
    t.integer  "board_space_id"
    t.integer  "message_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "board_spaces", force: :cascade do |t|
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dices", force: :cascade do |t|
    t.integer  "roll"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "number_of_turns",      default: 0
    t.integer  "current_player_id"
    t.string   "special_msg"
    t.string   "status"
    t.string   "user_prompt_question", default: ""
    t.string   "user_prompt_type",     default: ""
    t.string   "events",               default: [],              array: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "event"
    t.string   "event_type"
    t.string   "series"
    t.integer  "times_called", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "owned_stocks", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "company_name"
    t.float    "price"
    t.integer  "quantity"
    t.string   "s_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "pricing_plan_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "position",   default: 1
    t.boolean  "in_jail"
    t.integer  "igc_game"
    t.integer  "reputation"
    t.integer  "job"
    t.string   "token"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pricing_plans", force: :cascade do |t|
    t.integer  "price_of_coin"
    t.integer  "value_of_coin"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "company_name"
    t.float    "price"
    t.integer  "quantity"
    t.string   "s_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.integer  "IGC_total"
    t.integer  "IGC_base"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.string   "username"
    t.json     "avatars"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
