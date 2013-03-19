class AddSteamidAndXblaidAndPsnidAndWowidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :steamid, :string

    add_column :users, :xblaid, :string

    add_column :users, :psnid, :string

    add_column :users, :wowid, :string

  end
end
