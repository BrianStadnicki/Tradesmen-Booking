class RemoveTradesmenTradesFieldInTradesmenProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :tradesmen_profiles, :tradesmen_trades_id
  end
end
