class DeleteTradesmenTrades < ActiveRecord::Migration[6.1]
  def change
    drop_table :tradesmen_profile_trades
  end
end
