class AddIndexesToManyTables < ActiveRecord::Migration
  def change
    add_index "events", ["organizer_id"], :name => "index_events_on_organizer_id"
    add_index "invites", ["event_id"], :name => "index_invites_on_event_id"
    add_index "invites", ["user_id", "event_id"], :name => "index_invites_on_user_id_and_event_id"
    add_index "invites", ["user_id"], :name => "index_invites_on_user_id"
    add_index "game_ownerships", ["game_id"], :name => "index_game_ownerships_on_game_id"
    add_index "game_ownerships", ["user_id", "game_id"], :name => "index_game_ownerships_on_user_id_and_game_id", :unique => true
    add_index "game_ownerships", ["user_id"], :name => "index_game_ownerships_on_user_id"
    add_index "personas", ["game_id"], :name => "index_personas_on_game_id"
    add_index "personas", ["user_id", "game_id"], :name => "index_personas_on_user_id_and_game_id"
    add_index "personas", ["user_id"], :name => "index_personas_on_user_id"
  end
end
