class AddSubscriptionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :notification_subscription, :string
  end
end
