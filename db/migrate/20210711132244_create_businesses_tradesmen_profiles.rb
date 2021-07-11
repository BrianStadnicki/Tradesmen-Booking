class CreateBusinessesTradesmenProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses_tradesmen_profiles do |t|
      t.references :business, null: false, foreign_key: true
      t.references :tradesmen_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
