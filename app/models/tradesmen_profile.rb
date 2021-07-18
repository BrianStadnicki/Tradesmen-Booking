class TradesmenProfile < ApplicationRecord
  has_and_belongs_to_many :tradesmen_trades, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :jobs

  has_many :users_tradesmen_profile_user, class_name: 'TradesmenProfileUser', dependent: :destroy
  has_many :users, through: :users_tradesmen_profile_user, dependent: :destroy

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

  has_many :businesses_businesses_tradesmen_profiles, class_name: 'BusinessesTradesmenProfile', dependent: :destroy
  has_many :businesses, through: :businesses_businesses_tradesmen_profiles, source: :business

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 200 }
  validates :owner_id, presence: true
end
