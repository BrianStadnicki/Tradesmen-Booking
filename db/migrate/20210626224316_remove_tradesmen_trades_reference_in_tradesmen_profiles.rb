class RemoveTradesmenTradesReferenceInTradesmenProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_reference :tradesmen_profiles, :tradesmen_trades_id
  end
end
