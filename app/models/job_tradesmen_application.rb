class JobTradesmenApplication < ApplicationRecord
  belongs_to :job
  belongs_to :tradesmen_profile
end
