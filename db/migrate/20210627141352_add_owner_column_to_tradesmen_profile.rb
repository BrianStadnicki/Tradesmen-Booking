class AddOwnerColumnToTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :tradesmen_profiles, :owner, foreign_key: { to_table: :users }
  end
end
