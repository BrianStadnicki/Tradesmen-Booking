class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :type
      t.text :description
      t.string :address
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
