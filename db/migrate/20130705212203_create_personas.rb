class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :name
      t.string :server
      t.timestamps
    end
  end
end
