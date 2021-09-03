class AddTimestampToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :datetime, :datetime
  end
end
