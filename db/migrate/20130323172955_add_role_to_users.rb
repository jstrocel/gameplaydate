class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_id, :string

  end
end
