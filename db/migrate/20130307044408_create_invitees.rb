class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.integer :invite_id
      t.integer :user_id

      t.timestamps
    end
  end
end
