class RenameBeenCompletedToStatusBeenCompletedInJobs < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :been_completed, :status_been_completed
  end
end
