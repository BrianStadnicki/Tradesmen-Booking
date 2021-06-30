class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.string :phone2
      t.date :date_of_birth
      t.belongs_to :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
