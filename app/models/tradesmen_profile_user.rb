class TradesmenProfileUser < ApplicationRecord
  belongs_to :tradesmen_profile
  belongs_to :user
  belongs_to :role
end
