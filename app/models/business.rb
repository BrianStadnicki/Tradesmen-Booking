class Business < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy

  has_many :users, class_name: 'BusinessUser'
  has_many :admins, lambda {
                      BusinessUser.joins(:role).where(roles: { name: 'Admin' }).includes(:user)
                    }, class_name: 'BusinessUser'
  has_many :employees, lambda {
                         BusinessUser.joins(:role).where(roles: { name: 'Employee' }).includes(:user)
                       }, class_name: 'BusinessUser'
end
