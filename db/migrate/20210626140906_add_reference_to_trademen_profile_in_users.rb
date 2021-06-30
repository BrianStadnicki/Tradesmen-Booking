class AddReferenceToTrademenProfileInUsers < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :users, :tradesmen_profile
  end
end
