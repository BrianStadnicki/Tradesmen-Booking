class AddCompletedDateToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :completed, :date
  end
end
