class AddOwnerReferenceToTradesmenProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :tradesmen_profiles, :owner
  end
end
