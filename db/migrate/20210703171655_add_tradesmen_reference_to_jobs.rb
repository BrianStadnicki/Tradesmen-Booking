class AddTradesmenReferenceToJobs < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :tradesmen_profile, index: true
  end
end
