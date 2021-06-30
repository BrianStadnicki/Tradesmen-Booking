class RenameBusinessRoleToBusinessUser < ActiveRecord::Migration[6.1]
  def change
    rename_table :business_roles, :business_users
  end
end
