class Business < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :jobs

  has_many :users_business_user, class_name: 'BusinessUser',  dependent: :destroy
  has_many :users, through: :users_business_user, source: :user
  has_many :admins_business_user, lambda {
                      BusinessUser.joins(:role).where(roles: { name: 'Admin' }).includes(:user)
                    }, class_name: 'BusinessUser'
  has_many :admins, through: :admins_business_user, source: :user
  has_many :employees_business_user, lambda {
                         BusinessUser.joins(:role).where(roles: { name: 'Employee' }).includes(:user)
                       }, class_name: 'BusinessUser'

  has_many :tradesmen_businesses_tradesmen_profiles, class_name: 'BusinessesTradesmenProfile', dependent: :destroy
  has_many :tradesmen, through: :tradesmen_businesses_tradesmen_profiles, source: :tradesmen_profile

  has_many :employees, through: :employees_business_user, source: :user
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
end
