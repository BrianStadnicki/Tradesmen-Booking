class TradesmenTrade < ApplicationRecord
  has_and_belongs_to_many :tradesmen_profiles, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
end
