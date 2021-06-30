class RenameTypeInPlumberToTradesmenType < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :type, :tradesmen_type
  end
end
