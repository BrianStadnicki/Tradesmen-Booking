class RenameTradesmenProfileTradesToTradesmenProfilesTrades < ActiveRecord::Migration[6.1]
  def change
    rename_table :tradesmen_profile_users, :tradesmen_profiles_users
  end
end
