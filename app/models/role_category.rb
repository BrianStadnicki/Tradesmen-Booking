class RoleCategory < ApplicationRecord
  has_many :roles, dependent: :restrict_with_exception
end
