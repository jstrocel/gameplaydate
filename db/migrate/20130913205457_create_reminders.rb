class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer  "event_id"
      t.datetime "send_time"
      t.timestamps
    end
  end
end
