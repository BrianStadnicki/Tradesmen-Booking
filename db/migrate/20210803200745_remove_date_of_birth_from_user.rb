class RemoveDateOfBirthFromUser < ActiveRecord::Migration[6.1]
  def change
     remove_column :users, :date_of_birth, :date
  end
end
