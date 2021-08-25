class AddBeenCompletedToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :been_completed, :boolean
  end
end
