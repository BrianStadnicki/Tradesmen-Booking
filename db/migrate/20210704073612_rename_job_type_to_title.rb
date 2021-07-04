class RenameJobTypeToTitle < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :type, :title
  end
end
