class AddBeenStartedToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :status_been_started, :boolean
  end
end
