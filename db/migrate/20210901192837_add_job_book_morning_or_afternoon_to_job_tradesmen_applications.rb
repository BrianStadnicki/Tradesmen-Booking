class AddJobBookMorningOrAfternoonToJobTradesmenApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :job_tradesmen_applications, :morning, :boolean
    add_column :job_tradesmen_applications, :afternoon, :boolean
  end
end
