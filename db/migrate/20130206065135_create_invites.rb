class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :maximum_players
      t.datetime :fromtime
      t.datetime :totime
      t.timestamps
    end
  end
end
