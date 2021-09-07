class AddPostedDateToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :posted, :date
  end
end
