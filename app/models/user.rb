class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

end
