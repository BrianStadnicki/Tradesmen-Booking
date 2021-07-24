class Job < ApplicationRecord
  belongs_to :business
  belongs_to :tradesmen_profile, optional: true
  has_many :job_tradesmen_applications
  validates :title, presence: true, length: { maximum: 40 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :tradesmen_profile, presence: false
  validates :business, presence: true
  validates :status, presence: true, length: { maximum: 50 }
  validates :active, presence: true
end
