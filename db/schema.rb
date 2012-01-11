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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120110191627) do

  create_table "characters", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "member_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "game_id"
    t.date     "date"
    t.text     "site"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "name",                         :null => false
    t.boolean  "public",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "game_id",                       :null => false
    t.boolean  "game_admin", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["user_id", "game_id"], :name => "index_members_on_user_id_and_game_id", :unique => true

  create_table "registrations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "member_id"
    t.integer  "character_id"
    t.boolean  "paid"
    t.boolean  "present"
    t.boolean  "setup_cleanup"
    t.integer  "cp_game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "global_admin", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
