class AddCategoryReferenceToRoles < ActiveRecord::Migration[6.1]
  def change
    add_reference :roles, :role_categories
  end
end
