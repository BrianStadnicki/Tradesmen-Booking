class Role < ApplicationRecord
  has_many :users
  belongs_to :category, class_name: 'RoleCategory'
end
