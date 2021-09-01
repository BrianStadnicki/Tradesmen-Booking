class CreateNotificationsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.string :body
      t.string :type
      t.string :category

      t.timestamps
    end
  end
end
