class AddContactDetailsToTradesmenProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :tradesmen_profiles, :phone, :string
    add_column :tradesmen_profiles, :phone2, :string
    add_column :tradesmen_profiles, :email, :string
  end
end
