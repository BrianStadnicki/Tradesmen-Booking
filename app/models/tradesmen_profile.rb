class TradesmenProfile < ApplicationRecord
  has_and_belongs_to_many :tradesmen_trades
  belongs_to :owner, dependent: :destroy, class_name: 'User'
  has_many :jobs

  has_many :users, class_name: 'TradesmenProfileUser'
  has_many :admins, lambda {
                      TradesmenProfileUser.joins(:role).where(roles: { name: 'Admin' }).includes(:user)
                    }, class_name: 'TradesmenProfileUser'
  has_many :employees, lambda {
                         TradesmenProfileUser.joins(:role).where(roles: { name: 'Employee' }).includes(:user)
                       }, class_name: 'TradesmenProfileUser'

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 200 }
  validates :owner_id, presence: true
end
