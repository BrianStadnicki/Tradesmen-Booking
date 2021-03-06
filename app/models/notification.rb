class Notification < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 100 }
  validates :type_type, presence: true, length: { maximum: 40 }
  validates :type_category, presence: true, length: { maximum: 40 }
  validates :read, inclusion: { in: [true, false] }
  validates :datetime, presence: true
end
