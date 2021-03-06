class Job < ApplicationRecord
  belongs_to :business
  belongs_to :tradesmen_profile, optional: true
  belongs_to :job_tradesmen_application, optional: true
  has_many :job_tradesmen_applications, dependent: :destroy
  validates :title, presence: true, length: { maximum: 40 }
  validates :address_house_street, presence: true, length: { maximum: 100 }
  validates :address_city_town, presence: true, length: { maximum: 100 }
  validates :address_province_state, presence: true, length: { maximum: 100 }
  validates :address_post_code, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :tradesmen_profile, presence: false
  validates :business, presence: true
  validates :status, presence: true, length: { maximum: 50 }
  validates :active, inclusion: { in: [true, false] }
  validates :quote_required, inclusion: { in: [true, false] }
end
