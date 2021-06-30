class TradesmenTrade < ApplicationRecord
  has_and_belongs_to_many :tradesmen_profiles
end
