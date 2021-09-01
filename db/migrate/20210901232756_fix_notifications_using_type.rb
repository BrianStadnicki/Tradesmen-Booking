class FixNotificationsUsingType < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :type, :type_type
    rename_column :notifications, :category, :type_category
  end
end
