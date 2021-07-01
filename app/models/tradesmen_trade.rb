class TradesmenTrade < ApplicationRecord
  has_and_belongs_to_many :tradesmen_profiles

  validates :name, presence: true, length: { maximum: 20 }
end
