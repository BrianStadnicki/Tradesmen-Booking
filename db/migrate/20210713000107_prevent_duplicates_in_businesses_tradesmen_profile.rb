class PreventDuplicatesInBusinessesTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    add_index :businesses_tradesmen_profiles, [:business_id, :tradesmen_profile_id], unique: true,
              name: 'index_on_businesses_tradesmen_profiles_uniqueness'
  end
end
