class CreateNotificationPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_preferences do |t|
      t.references :user
      t.string :category
      t.string :type_

      t.timestamps
    end
  end
end
