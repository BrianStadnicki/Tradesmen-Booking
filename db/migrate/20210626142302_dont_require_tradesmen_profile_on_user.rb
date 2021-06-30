class DontRequireTradesmenProfileOnUser < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :tradesmen_profile_id, true
  end
end
