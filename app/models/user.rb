class User < ApplicationRecord
  belongs_to :role
  has_one :business, required: false, foreign_key: 'owner_id'
  has_one :tradesmen_profile, required: false, foreign_key: 'owner_id'
end
