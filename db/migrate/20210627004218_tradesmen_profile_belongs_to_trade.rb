class TradesmenProfileBelongsToTrade < ActiveRecord::Migration[6.1]
  def change
    create_join_table :tradesmen_profiles, :tradesmen_trades do |t|
      t.index %i[tradesmen_profile_id tradesmen_trade_id], name: 'index_tradesmen_profile_on_profile_id_and_trade_id'
    end
  end
end
