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

ActiveRecord::Schema.define(version: 20130628214623) do

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

  create_table "friendships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendships", ["followed_id"], name: "index_friendships_on_followed_id"
  add_index "friendships", ["follower_id", "followed_id"], name: "index_friendships_on_follower_id_and_followed_id", unique: true
  add_index "friendships", ["follower_id"], name: "index_friendships_on_follower_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "platform"
  end

  create_table "invites", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "accepted"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "steamid"
    t.string   "xblaid"
    t.string   "psnid"
    t.string   "wowid"
    t.string   "role_id"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "beta_invitation_id"
    t.integer  "beta_invitation_limit"
  end

end
