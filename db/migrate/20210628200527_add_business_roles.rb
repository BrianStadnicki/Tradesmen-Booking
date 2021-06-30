class AddBusinessRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :business_roles do |t|
      t.references :business
      t.references :user
      t.references :role
    end
  end
end
