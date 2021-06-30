class CreateTradesmenProfileUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :tradesmen_profile_users do |t|
      t.references :tradesmen_profile, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
