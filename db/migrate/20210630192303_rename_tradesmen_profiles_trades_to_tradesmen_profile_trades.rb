class RenameTradesmenProfilesTradesToTradesmenProfileTrades < ActiveRecord::Migration[6.1]
  def change
    rename_table :tradesmen_profiles_trades, :tradesmen_profile_trades
  end
end
