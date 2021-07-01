class Role < ApplicationRecord
  has_many :users
  belongs_to :category, class_name: 'RoleCategory'

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }
end
