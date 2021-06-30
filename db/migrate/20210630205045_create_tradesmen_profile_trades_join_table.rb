class CreateTradesmenProfileTradesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :tradesmen_profiles, :tradesmen_trades do |t|
      t.index :tradesmen_profile_id
      t.index :tradesmen_trade_id
    end
  end
end
