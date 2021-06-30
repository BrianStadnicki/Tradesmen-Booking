class AddUserToTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :tradesmen_profiles, :user, foreign_key: true
  end
end
