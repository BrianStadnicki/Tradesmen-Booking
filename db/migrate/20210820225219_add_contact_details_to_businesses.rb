class AddContactDetailsToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :phone2, :string, null: true
    add_column :businesses, :email, :string, null: true
  end
end
