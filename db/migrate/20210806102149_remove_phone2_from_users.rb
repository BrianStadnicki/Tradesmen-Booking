class RemovePhone2FromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :phone2, :string
  end
end
