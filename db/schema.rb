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

ActiveRecord::Schema.define(version: 20130809164917) do

  create_table "beta_invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "game_id"
    t.integer  "organizer_id"
    t.integer  "maximum_players"
    t.datetime "fromtime"
    t.datetime "totime"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "content"
  end

  add_index "events", ["organizer_id"], name: "index_events_on_organizer_id"

  create_table "friendships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendships", ["followed_id"], name: "index_friendships_on_followed_id"
  add_index "friendships", ["follower_id", "followed_id"], name: "index_friendships_on_follower_id_and_followed_id", unique: true
  add_index "friendships", ["follower_id"], name: "index_friendships_on_follower_id"

  create_table "game_ownerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_ownerships", ["game_id"], name: "index_game_ownerships_on_game_id"
  add_index "game_ownerships", ["user_id", "game_id"], name: "index_game_ownerships_on_user_id_and_game_id", unique: true
  add_index "game_ownerships", ["user_id"], name: "index_game_ownerships_on_user_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "platform"
  end

  create_table "invites", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "status",     default: "pending"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "accepted"
  end

  add_index "invites", ["event_id"], name: "index_invites_on_event_id"
  add_index "invites", ["user_id", "event_id"], name: "index_invites_on_user_id_and_event_id"
  add_index "invites", ["user_id"], name: "index_invites_on_user_id"

  create_table "personas", force: true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "server"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas", ["game_id"], name: "index_personas_on_game_id"
  add_index "personas", ["user_id", "game_id"], name: "index_personas_on_user_id_and_game_id"
  add_index "personas", ["user_id"], name: "index_personas_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "steamid"
    t.string   "xblaid"
    t.string   "psnid"
    t.string   "wowid"
    t.string   "role",                   default: "user"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "beta_invitation_id"
    t.integer  "beta_invitation_limit",  default: 0
  end

end
