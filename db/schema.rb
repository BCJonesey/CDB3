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

ActiveRecord::Schema.define(version: 20131126164754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: true do |t|
    t.integer  "character_id"
    t.integer  "approved_by_id"
    t.integer  "created_by_id"
    t.text     "comment"
    t.decimal  "amount"
    t.integer  "currency_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_skills", force: true do |t|
    t.integer  "character_version_id"
    t.integer  "skill_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_versions", force: true do |t|
    t.integer  "previous_version_id"
    t.string   "description",         default: "Current Version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "character_id"
  end

  create_table "characters", force: true do |t|
    t.string   "name",                 null: false
    t.integer  "member_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "character_version_id"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "yearly_cap"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "game_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "site"
    t.text     "notes"
    t.integer  "player_cap"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name",                      null: false
    t.string   "slug",                      null: false
    t.boolean  "public",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["slug"], name: "index_games_on_slug", unique: true, using: :btree

  create_table "members", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "game_id",                    null: false
    t.boolean  "game_admin", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["user_id", "game_id"], name: "index_members_on_user_id_and_game_id", unique: true, using: :btree

  create_table "registrations", force: true do |t|
    t.integer  "event_id"
    t.integer  "member_id"
    t.integer  "character_id"
    t.boolean  "is_paid",       default: false
    t.boolean  "is_present",    default: false
    t.boolean  "is_prereged",   default: false
    t.boolean  "setup_cleanup", default: false
    t.integer  "cp_game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_tags", force: true do |t|
    t.boolean  "gives",      default: false
    t.integer  "skill_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.string   "summary"
    t.text     "description"
    t.integer  "min_rank",    default: 0
    t.integer  "max_rank",    default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cost"
    t.text     "rule"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                                            null: false
    t.string   "email",                                           null: false
    t.boolean  "global_admin",                    default: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
