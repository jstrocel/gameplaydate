class AddContentToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :content, :string

  end
end
