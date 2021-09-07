class AddIndexesToNotificationPreferences < ActiveRecord::Migration[6.1]
  def change
    add_index :notification_preferences, :category
    add_index :notification_preferences, :type_
  end
end
