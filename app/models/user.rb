class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  belongs_to :role
  has_one :business, required: false, foreign_key: 'owner_id', dependent: :destroy
  has_one :tradesmen_profile, required: false, foreign_key: 'owner_id', dependent: :destroy
  has_one :tradesmen_profile_user, required: false
  has_one :business_user, required: false

  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :phone, presence: true, length: { maximum: 30 }
  validates :phone2, allow_blank: true, length: { maximum: 30 }
  validates :date_of_birth, presence: true

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
