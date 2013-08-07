class AddBetaInvitationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :beta_invitation_id, :integer
    add_column :users, :beta_invitation_limit, :integer, default: 0
  end
end
