class AddStatusToJob < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :status, :string
    add_column :jobs, :active, :boolean
  end
end
