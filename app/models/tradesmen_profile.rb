class TradesmenProfile < ApplicationRecord
  has_and_belongs_to_many :tradesmen_trades
  belongs_to :owner, dependent: :destroy, class_name: 'User'
  has_many :jobs

  has_many :users_tradesmen_profile_user, class_name: 'TradesmenProfileUser'
  has_many :users, through: :users_tradesmen_profile_user

  has_many :admins_tradesmen_profile_user,
           lambda {
             TradesmenProfileUser.joins(:role).where(roles: { name: 'Admin' }).includes(:user)
           }, class_name: 'TradesmenProfileUser'
  has_many :admins, through: :admins_tradesmen_profile_user, source: :user

  has_many :employees_tradesmen_profile_user,
           lambda {
             TradesmenProfileUser.joins(:role).where(roles: { name: 'Employee' }).includes(:user)
           }, class_name: 'TradesmenProfileUser'
  has_many :employees, through: :employees_tradesmen_profile_user, source: :user

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 200 }
  validates :owner_id, presence: true
end
