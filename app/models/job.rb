class Job < ApplicationRecord
  belongs_to :business
  validates :type, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 2000 }
end
