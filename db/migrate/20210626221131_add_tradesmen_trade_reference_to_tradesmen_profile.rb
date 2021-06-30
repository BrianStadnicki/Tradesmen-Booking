class AddTradesmenTradeReferenceToTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :tradesmen_profiles, :tradesmen_trades
  end
end
