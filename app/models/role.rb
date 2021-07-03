class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception
  belongs_to :category, class_name: 'RoleCategory'

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }

  scope :user_category, -> { joins(:category).where(category: { name: 'User' }) }
end
