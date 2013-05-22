class AddPlatformToGames < ActiveRecord::Migration
  def change
    add_column :games, :platform, :string

  end
end
