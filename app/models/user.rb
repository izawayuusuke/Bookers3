class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

has_many :active_relationships, class_name: "Relationship",
                    foreign_key: "follower_id",
                    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                    foreign_key: "followed_id",
                    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
