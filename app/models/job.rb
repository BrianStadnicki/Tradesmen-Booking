class Job < ApplicationRecord
  belongs_to :business
  belongs_to :tradesmen_profile, optional: true
  validates :title, presence: true, length: { maximum: 40 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :tradesmen_profile, presence: false
  validates :business, presence: true
end
