class InitialData < ActiveRecord::Migration

  def change
    create_table "users", :force => true do |t|
      t.string   "name"
      t.string   "email"
      t.boolean  "admin",           :default => false
      t.datetime "created_at",                         :null => false
      t.datetime "updated_at",                         :null => false
      t.string   "password_digest"
      t.string   "remember_token"
      t.string   "steamid"
      t.string   "xblaid"
      t.string   "psnid"
      t.string   "wowid"
      t.string   "role", :default => "user"
    end

    create_table "events", :force => true do |t|
      t.integer  "game_id"
      t.integer  "organizer_id"
      t.integer  "maximum_players"
      t.datetime "fromtime"
      t.datetime "totime"
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
      t.string   "content"
    end  
    
    
    
    create_table "invites", :force => true do |t|
     t.integer  "event_id"
     t.integer  "user_id"
     t.string  "status",  default: 'pending'
     t.datetime "created_at", :null => false
     t.datetime "updated_at", :null => false
     t.boolean  "accepted"
    end
    

    

    create_table "friendships", :force => true do |t|
     t.integer  "follower_id"
     t.integer  "followed_id"
     t.datetime "created_at",  :null => false
     t.datetime "updated_at",  :null => false
    end

    add_index "friendships", ["followed_id"], :name => "index_friendships_on_followed_id"
    add_index "friendships", ["follower_id", "followed_id"], :name => "index_friendships_on_follower_id_and_followed_id", :unique => true
    add_index "friendships", ["follower_id"], :name => "index_friendships_on_follower_id"

    create_table "games", :force => true do |t|
     t.string   "name"
     t.datetime "created_at", :null => false
     t.datetime "updated_at", :null => false
     t.string   "platform"
    end

  end
end