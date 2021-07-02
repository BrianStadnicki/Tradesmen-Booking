class Business < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy
  has_many :jobs

  has_many :users, class_name: 'BusinessUser'
  has_many :admins, lambda {
                      BusinessUser.joins(:role).where(roles: { name: 'Admin' }).includes(:user)
                    }, class_name: 'BusinessUser'
  has_many :employees, lambda {
                         BusinessUser.joins(:role).where(roles: { name: 'Employee' }).includes(:user)
                       }, class_name: 'BusinessUser'

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :owner_id, presence: true
end
