class AddIndexOfReadToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_index :notifications, :read
  end
end
