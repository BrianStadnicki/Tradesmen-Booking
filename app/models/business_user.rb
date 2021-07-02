class BusinessUser < ApplicationRecord
  belongs_to :business
  belongs_to :user
  belongs_to :role

  validates :business_id, presence: true
  validates :user_id, presence: true
  validates :role_id, presence: true
end
