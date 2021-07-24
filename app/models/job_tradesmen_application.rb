class JobTradesmenApplication < ApplicationRecord
  belongs_to :job
  belongs_to :tradesmen_profile

  validates :date, presence: true, inclusion: { in: (Date.today..Float::INFINITY) }
end
