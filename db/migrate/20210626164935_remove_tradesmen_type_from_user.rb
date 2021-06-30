class RemoveTradesmenTypeFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :tradesmen_profile_id
  end
end
