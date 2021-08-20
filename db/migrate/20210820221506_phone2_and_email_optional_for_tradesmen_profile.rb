class Phone2AndEmailOptionalForTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :tradesmen_profiles, :phone2, :string, null: true
    change_column :tradesmen_profiles, :email, :string, null: true
  end
end
