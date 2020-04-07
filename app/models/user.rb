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
  validates :postal_code, :prefecture_code,
      :address_city, :address_street, presence: true

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def User.search(search, user_or_book, how_search)
    if user_or_book == "0"
      if how_search == "0"
        User.where(['name LIKE ?', "#{search}"])
      elsif how_search == "1"
        User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == "2"
        User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == "3"
        User.where(['name LIKE ?', "%#{search}%"])
      else
        User.none
      end
    end
  end
end
