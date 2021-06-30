class RenameTradesmenProfilesUsersToTradesmenProfileUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :tradesmen_profiles_users, :tradesmen_profile_users
  end
end
