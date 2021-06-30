class TradesmenProfilesTrades < ApplicationRecord
  belongs_to :tradesmen_profile
  belongs_to :tradesmen_trade
end
