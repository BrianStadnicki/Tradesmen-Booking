class BusinessUser < ApplicationRecord
  belongs_to :business
  belongs_to :user
  belongs_to :role
end
