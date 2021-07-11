class BusinessesTradesmenProfile < ApplicationRecord
  belongs_to :business
  belongs_to :tradesmen_profile
end
