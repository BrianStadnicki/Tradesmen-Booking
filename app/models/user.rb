class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  belongs_to :role
  has_one :business, required: false, foreign_key: 'owner_id', dependent: :destroy
  has_one :tradesmen_profile, required: false, foreign_key: 'owner_id', dependent: :destroy
  has_one :tradesmen_profile_user, required: false
  has_one :tradesmen_profile_belongs, through: :tradesmen_profile_user, source: :tradesmen_profile
  has_one :business_user, required: false
  has_one :business_belongs, through: :business_user, source: :business

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :phone, presence: true, length: { maximum: 30 }
  validates :phone2, allow_blank: true, length: { maximum: 30 }

  def admin?
    role.name == 'Admin'
  end

  def tradesmen?
    role.name == 'Tradesman'
  end

  def booker?
    role.name == 'Booker'
  end
end
