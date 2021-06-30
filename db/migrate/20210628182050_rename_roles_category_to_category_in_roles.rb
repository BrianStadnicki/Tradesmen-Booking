class RenameRolesCategoryToCategoryInRoles < ActiveRecord::Migration[6.1]
  def change
    rename_column :roles, :role_categories_id, :category_id
  end
end
