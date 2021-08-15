class AddQuoteRequiredToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :quote_required, :boolean
  end
end
