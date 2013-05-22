class AddHostToInvitees < ActiveRecord::Migration
  def change
    add_column :invitees, :host, :boolean
  end
end
