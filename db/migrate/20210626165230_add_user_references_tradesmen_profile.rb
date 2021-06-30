class AddUserReferencesTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :tradesmen_profile, foreign_key: true, null: true
  end
end
