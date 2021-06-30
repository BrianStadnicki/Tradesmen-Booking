class RemoveTradesmenTypeFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :tradesmen_type
  end
end
