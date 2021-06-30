class CreateRoleCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :role_categories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
