class JobTradesmenApplication < ApplicationRecord
  belongs_to :job
  belongs_to :tradesmen_profile

  validates :date, presence: true
  validates_inclusion_of :date, in: (Date.today..Float::INFINITY), message: 'Must not be in past'
end
