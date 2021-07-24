class CreateJobTradesmenApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :job_tradesmen_applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :tradesmen_profile, null: false, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end
  end
end
